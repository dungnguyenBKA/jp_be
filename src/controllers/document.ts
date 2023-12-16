import {Router} from "express";
import {makeError, makeErrorInCatch, makeSuccess} from "../utils/BaseResponse";
import {AppDataSource} from "../services/dbService";
import DocumentEntity from "../entity/DocumentEntity";
import {UserModel} from "../entity/UserModel";
import {body, validationResult} from "express-validator";
import AppUtils, {tryParseInt} from "../utils/AppUtils";
import UserViewDocumentEntity from "../entity/UserViewDocumentEntity";
import CategoryEntity from "../entity/CategoryEntity";
import {DeepPartial, In, Like} from "typeorm";
import LecturerEntity from "../entity/LecturerEntity";
import SubjectEntity from "../entity/SubjectEntity";
import multer from 'multer'
import path from "path";
import FileEntity from "../entity/FileEntity";

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null,'uploads');
  },
  filename: function (req, file, cb) {
    const extname = path.extname(file.originalname).toLowerCase()
    const name = `${Date.now()}${extname}`
    cb(null, name);
  }
})

const upload = multer({
  storage,
  fileFilter(req, file, callback) {
    const filetypes = /pdf|docx/;
    // Check ext
    const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
    // Check mime
    const mimetype = filetypes.test(file.mimetype);

    console.log({mimetype, extname})
    if(mimetype && extname){
      return callback(null, true);
    }
    callback(null, false)
  },
})

const router = Router()
const documentRepository = AppDataSource.getRepository(DocumentEntity)
const categoryEntityRepository = AppDataSource.getRepository(CategoryEntity)
const lecturerEntityRepository = AppDataSource.getRepository(LecturerEntity)
const subjectEntityRepository = AppDataSource.getRepository(SubjectEntity)
const userRepository = AppDataSource.getRepository(UserModel)
const userViewDocRepo = AppDataSource.getRepository(UserViewDocumentEntity)
const fileEntityRepository = AppDataSource.getRepository(FileEntity)

router.get("/detail/:id",
  async (req, res) => {
    try {
      const docId = tryParseInt(req.params.id, -1)
      const user: UserModel = req.body["performer"]
      const now = new Date()

      const document = await documentRepository.findOne({
        where: {
          id: docId
        },
        relations: {
          categories: true,
          lecturer: {
            school: true
          },
          uploader: true,
          subject: true,
          files: true
        }
      })

      if (document) {
        const userViewDocResult = await userViewDocRepo.findOne({
          where: {
            user: {
              id: user.id
            },
            document: {
              id: docId
            }
          }
        })

        if (userViewDocResult) {
          // update
          await userViewDocRepo.save({
            id: userViewDocResult.id,
            user,
            document,
            view_at: now
          })
        } else {
          // create
          await userViewDocRepo.save({
            user,
            document,
            view_at: now
          })
        }

        return makeSuccess(res, document)
      }
      return makeError(res, 404, "No document with this id")
    } catch (e) {
      return makeError(res, 400, JSON.stringify(e))
    }
  })

router.get("/list/all", async (req, res) => {
  try {
    const query = req.query
    const qName = req.query['name']?.toString() || ""

    const page = tryParseInt(req.query["page"], 0) || 0
    const perPage = tryParseInt(req.query["per_page"], 5) || 5
    const startIndex = page * perPage

    const result = await documentRepository.find({
      where: {
        title: Like(`%${qName}%`)
      },
      relations: {
        categories: true,
        lecturer: {
          school: true
        },
        subject: true,
        files: true
      },
    })

    const pagingData = result.slice(startIndex, startIndex + perPage)
    return makeSuccess(res, pagingData)
  } catch (e) {
    return makeError(res, 400, JSON.stringify(e))
  }
})

router.get("/list/recent-view", async (req, res) => {
  try {
    const user: UserModel = req.body["performer"]

    const result = await userViewDocRepo.find({
      where: {
        user: {
          id: user.id
        }
      },
      relations: {
        document: true,
      },
      order: {
        view_at: "DESC"
      },
      take: 5
    })

    return makeSuccess(res, result)
  } catch (e) {
    return makeError(res, 400, JSON.stringify(e))
  }
})

router.get("/list/:id", async (req, res) => {
  try {
    const userId = tryParseInt(req.params.id, -1)

    const user = await userRepository.findOne({
      where: {
        id: userId
      },
      relations: {
        documents: {
          categories: true,
          lecturer: {
            school: true
          },
          subject: true,
          files: true,
        },
      },
    })

    if (user == null) {
      return makeError(res, 404, "User is not valid!")
    }

    return makeSuccess(res, user.documents)
  } catch (e) {
    return makeError(res, 400, JSON.stringify(e))
  }
})

router.post("/create",
  upload.array('files'),
  body("title").notEmpty(),
  body("categories").notEmpty(),
  body("lecturer_id").isNumeric(),
  body("subject_id").isNumeric(),
  async (req, res,) => {
    try {
      const errors = validationResult(req);
      const user: UserModel = req.body["performer"]
      const categoryIds: string[] = (req.body["categories"] as string).split(",")
      const lecturer_id = tryParseInt(req.body["lecturer_id"], -1)
      const subject_id = tryParseInt(req.body["subject_id"], -1)

      if (!errors.isEmpty()) {
        return makeError(res, 404, AppUtils.getValidateError(errors))
      }

      console.log(req.body)
      console.log(req.files)

      const files = (req.files || []) as Express.Multer.File[]
      if (files.length === 0) {
        return makeError(res, 404, "Files pdf AND/OR docx is required")
      }

      const lecturer = await lecturerEntityRepository.findOne({
        where: {
          id: lecturer_id
        }
      })

      if (!lecturer) {
        return makeError(res, 400, `No lecturer with id ${lecturer_id}`)
      }

      const subject = await subjectEntityRepository.findOne({
        where: {
          id: subject_id
        }
      })

      if (!subject) {
        return makeError(res, 400, `No subject with id ${subject_id}`)
      }

      const categoryEntities = await categoryEntityRepository.find({
        where: {
          id: In(categoryIds)
        }
      })

      const insertDoc = await documentRepository.save({
        title: req.body["title"],
        description: req.body["description"],
        semester: req.body["semester"],
        uploader: user,
        categories: categoryEntities,
        lecturer,
        subject,
      })

      await fileEntityRepository.save(
        files.map(item => {
          return {
            url: item.filename,
            document: insertDoc
          } as DeepPartial<FileEntity>
        })
      )

      const result = await documentRepository.findOne({
        where: {
          id: insertDoc.id
        },
        relations: {
          uploader: true,
          categories: true,
          lecturer: {
            school: true
          },
          subject: true,
          files: true
        }
      })

      return makeSuccess(res, result)
    } catch (e) {
      return makeErrorInCatch(res, e)
    }
  },
)

router.post("/verify-document",
  body("id").notEmpty(),
  body("is_verify").isBoolean().notEmpty(),
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return makeError(res, 404, AppUtils.getValidateError(errors))
      }

      const docId = tryParseInt(req.body["id"], -1)
      const currentUser: UserModel = req.body["performer"]

      if (currentUser.role === "admin") {
        const document = await documentRepository.findOne({
          where: {
            id: docId
          },
        })

        if (document) {
          const result = await documentRepository.save({
            ...document,
            is_verified: req.body["is_verify"]
          })
          return makeSuccess(res, result)
        }

        return makeError(res, 404, "No document with this id")
      } else {
        return makeError(res, 404, "Only admin can verify documents!")
      }
    } catch (e) {
      return makeError(res, 400, JSON.stringify(e))
    }
  })

export default router
