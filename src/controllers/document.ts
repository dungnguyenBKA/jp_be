import {Router} from "express";
import {makeError, makeErrorInCatch, makeSuccess} from "../utils/BaseResponse";
import {AppDataSource} from "../services/dbService";
import DocumentEntity from "../entity/DocumentEntity";
import {UserModel} from "../entity/UserModel";
import {body, validationResult} from "express-validator";
import AppUtils, {toLowerCaseNonAccentVietnamese, tryParseInt} from "../utils/AppUtils";
import UserViewDocumentEntity from "../entity/UserViewDocumentEntity";
import CategoryEntity from "../entity/CategoryEntity";
import {DeepPartial, FindOptionsWhere, In} from "typeorm";
import LecturerEntity from "../entity/LecturerEntity";
import SubjectEntity from "../entity/SubjectEntity";
import multer from 'multer'
import path from "path";
import FileEntity from "../entity/FileEntity";
import CommentEntity from "../entity/CommentEntity";
import UserReactDocumentEntity from "../entity/UserReactDocumentEntity";
import {isNaN} from "lodash";
import SemesterEntity from "../entity/SemesterEntity";

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads');
  },
  filename: function (req, file, cb) {
    const extname = path.extname(file.originalname).toLowerCase()
    const name = `${Date.now()}${extname}`
    cb(null, name);
  }
})

enum MIMETYPE {
  JPG = "image/jpeg",
  PNG = "image/png",
  PDF = "application/pdf",
  DOCX = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
}

const upload = multer({
  storage,
  fileFilter(req, file, callback) {
    const allowedMimes = [MIMETYPE.JPG, MIMETYPE.PNG, MIMETYPE.PDF, MIMETYPE.DOCX];
    if (allowedMimes.includes(file.mimetype as MIMETYPE)) {
      callback(null, true);
    } else {
      callback(new Error('Invalid file type. Only JPEG, PNG, PDF, and DOCX files are allowed.'));
    }
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
const commentEntityRepository = AppDataSource.getRepository(CommentEntity)
const userReactDocumentEntityRepository = AppDataSource.getRepository(UserReactDocumentEntity)
const semesterEntityRepository = AppDataSource.getRepository(SemesterEntity)

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
          files: true,
          comments: {
            author: true
          },
          userReactDocuments: {
            author: true
          }
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


function _getListId(input?: string): number[] {
  if (!input) {
    return []
  }

  return input.split(",")
    .map(item => tryParseInt(item, -1))
    .filter(item => !isNaN(item))
}

router.get("/list/all", async (req, res) => {
  try {
    const keyword = req.query['keyword']?.toString() || ""
    const lecturer_id = _getListId(req.query['lecturer_id']?.toString())
    const school_id = _getListId(req.query['school_id']?.toString())
    const subject_id = _getListId(req.query['subject_id']?.toString())
    const semester_id = _getListId(req.query['semester_id']?.toString())
    const category_id = _getListId(req.query['category_id']?.toString())

    const page = tryParseInt(req.query["page"], 0) || 0
    const perPage = tryParseInt(req.query["per_page"], 5) || 5
    const startIndex = page * perPage

    const entityOption: FindOptionsWhere<DocumentEntity> = {
      ...(
        (lecturer_id.length > 0 || school_id.length > 0) && {
          lecturer: {
            ...(lecturer_id.length > 0 && {
              id: In(lecturer_id)
            }),
            ...(school_id.length > 0 && {
              school: {
                id: In(school_id)
              }
            })
          }
        }
      ),
      ...(
        subject_id.length > 0 && {
          subject: {
            id: In(subject_id)
          }
        }
      ),
      ...(
        semester_id.length > 0 && {
          semester: {
            id: In(semester_id)
          }
        }
      ),
    }

    const result = await documentRepository.find({
      where: entityOption,
      relations: {
        categories: true,
        lecturer: {
          school: true
        },
        subject: true,
        files: true,
        semester: true,
      },
    })

    const filter
      = result
      .filter(item => toLowerCaseNonAccentVietnamese(item.title).includes(toLowerCaseNonAccentVietnamese(keyword)))
      .filter(item => item.categories.some(cate => category_id.length === 0 ? true : category_id.includes(cate.id)))

    const pagingData = filter.slice(startIndex, startIndex + perPage)
    return makeSuccess(res, {
      total_count: filter.length,
      data: pagingData
    })
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
        document: {
          files: true,
          userReactDocuments: {
            author: true
          }
        },
      },
      order: {
        view_at: "DESC"
      },
      take: 5
    })

    const page = tryParseInt(req.query["page"], 0) || 0
    const perPage = tryParseInt(req.query["per_page"], 5) || 5
    const startIndex = page * perPage

    const pagingData = result.slice(startIndex, startIndex + perPage)
    return makeSuccess(res, {
      total_count: result.length,
      data: pagingData
    })
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
          semester: true,
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

function getFirstItem<T>(arr: T[]): T | undefined {
  return arr.length > 0 ? arr[0] : undefined;
}

router.post("/create",
  upload.array('files'),
  body("title").notEmpty(),
  body("categories").notEmpty(),
  body("lecturer_id").isNumeric(),
  body("subject_id").isNumeric(),
  body("semester_id").isNumeric(),
  async (req, res,) => {
    try {
      const errors = validationResult(req);

      // @ts-ignore
      const user: UserModel = req.user
      const categoryIds: string[] = (req.body["categories"] as string).split(",")
      const lecturer_id = tryParseInt(req.body["lecturer_id"], -1)
      const subject_id = tryParseInt(req.body["subject_id"], -1)
      const semester_id = tryParseInt(req.body["semester_id"], -1)

      if (!errors.isEmpty()) {
        return makeError(res, 404, AppUtils.getValidateError(errors))
      }

      const files = (req.files || []) as Express.Multer.File[]

      const documents = files.filter(file => {
        return file.mimetype === MIMETYPE.DOCX || file.mimetype === MIMETYPE.PDF
      })

      const evidences = files.filter(file => {
        return file.mimetype === MIMETYPE.PNG || file.mimetype === MIMETYPE.JPG
      })

      if (documents.length === 0) {
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

      const semester = await semesterEntityRepository.findOne({
        where: {
          id: semester_id
        }
      })

      if (!semester) {
        return makeError(res, 400, `No semester with id ${semester_id}`)
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
        semester: semester,
        uploader: user,
        categories: categoryEntities,
        lecturer,
        subject,
        evidence_url: getFirstItem(evidences)?.filename
      })

      await fileEntityRepository.save(
        documents.map(item => {
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
          files: true,
          semester: true,
        }
      })

      return makeSuccess(res, result)
    } catch (e) {
      console.log("Hello")
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


router.post("/vote",
  body("id").notEmpty(),
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return makeError(res, 404, AppUtils.getValidateError(errors))
      }

      const docId = tryParseInt(req.body["id"], -1)
      const currentUser: UserModel = req.body["performer"]

      if (req.body["vote"] !== undefined && typeof req.body["vote"] !== "boolean") {
        return makeError(res, 404, "Vote's value should be true | false | undefined")
      }

      const vote: boolean | undefined = req.body["vote"] // true | false | undefined <=> like | dislike | no vote

      const document = await documentRepository.findOne({
        where: {
          id: docId
        },
      })

      if (!document) {
        return makeError(res, 404, "No document with this id")
      }

      const previousReact = await userReactDocumentEntityRepository.findOne({
        where: {
          author: {
            id: currentUser.id
          },
          document: {
            id: docId
          }
        }
      })

      console.log({vote})
      if (previousReact) {
        if (vote !== undefined) {
          await userReactDocumentEntityRepository.save({
            id: previousReact.id,
            vote,
            author: currentUser,
            document: document
          })
        } else {
          await userReactDocumentEntityRepository.delete({
            id: previousReact.id
          })
        }
      } else {
        if (vote !== undefined) {
          await userReactDocumentEntityRepository.save({
            vote,
            author: currentUser,
            document: document
          })
        } else {
          await userReactDocumentEntityRepository.delete({
            author: {
              id: currentUser.id
            },
            document: {
              id: docId
            }
          })
        }
      }

      const result = await documentRepository.findOne({
        where: {
          id: docId,
        },
        relations: {
          userReactDocuments: {
            author: true
          }
        }
      })

      return makeSuccess(res, result)

    } catch (e) {
      return makeError(res, 400, JSON.stringify(e))
    }
  })


router.post("/comment",
  body("id").notEmpty(),
  body("content").isString().notEmpty(),
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return makeError(res, 404, AppUtils.getValidateError(errors))
      }

      const docId = tryParseInt(req.body["id"], -1)
      const content = req.body["content"]
      const currentUser: UserModel = req.body["performer"]

      const document = await documentRepository.findOne({
        where: {
          id: docId
        },
      })

      if (!document) {
        return makeError(res, 404, "No document with this id")
      }

      const result = await commentEntityRepository.save({
        content,
        author: currentUser,
        document: document
      })

      return makeSuccess(res, result)

    } catch (e) {
      return makeError(res, 400, JSON.stringify(e))
    }
  })

export default router
