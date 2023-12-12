import {Router} from "express";
import {makeError, makeErrorInCatch, makeSuccess} from "../utils/BaseResponse";
import {AppDataSource} from "../services/dbService";
import DocumentEntity from "../entity/DocumentEntity";
import {UserModel} from "../entity/UserModel";
import {body, validationResult} from "express-validator";
import AppUtils, {tryParseInt} from "../utils/AppUtils";
import UserViewDocumentEntity from "../entity/UserViewDocumentEntity";
import CategoryEntity from "../entity/CategoryEntity";
import {In, Like} from "typeorm";
import LecturerEntity from "../entity/LecturerEntity";
import SubjectEntity from "../entity/SubjectEntity";

const router = Router()
const documentRepository = AppDataSource.getRepository(DocumentEntity)
const categoryEntityRepository = AppDataSource.getRepository(CategoryEntity)
const lecturerEntityRepository = AppDataSource.getRepository(LecturerEntity)
const subjectEntityRepository = AppDataSource.getRepository(SubjectEntity)
const userRepository = AppDataSource.getRepository(UserModel)
const userViewDocRepo = AppDataSource.getRepository(UserViewDocumentEntity)

router.get("/detail/:id",
  async (req, res) => {
    try {
      const docId = tryParseInt(req.params.id, -1)
      const user: UserModel = req.body["performer"]

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
          subject: true
        }
      })

      if (document) {
        await userViewDocRepo.save({
          user,
          document
        })

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
        subject: true
      },
    })

    const pagingData = result.slice(startIndex, startIndex + perPage)
    return makeSuccess(res, pagingData)
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
          subject: true
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
  body("title").notEmpty(),
  body("download_url").notEmpty(),
  body("categories").isArray().notEmpty(),
  body("lecturer_id").isNumeric(),
  body("subject_id").isNumeric(),
  async (req, res,) => {
    try {
      const errors = validationResult(req);
      const user: UserModel = req.body["performer"]
      const categoryIds: string[] = req.body["categories"]
      const lecturer_id = req.body["lecturer_id"]
      const subject_id = req.body["subject_id"]

      if (!errors.isEmpty()) {
        return makeError(res, 404, AppUtils.getValidateError(errors))
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

      const insert = await documentRepository.save({
        title: req.body["title"],
        description: req.body["description"],
        download_url: req.body["download_url"],
        semester: req.body["semester"],
        uploader: user,
        categories: categoryEntities,
        lecturer,
        subject,
      })

      const result = await documentRepository.findOne({
        where: {
          id: insert.id
        },
        relations: {
          uploader: true,
          categories: true,
          lecturer: {
            school: true
          },
          subject: true
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
