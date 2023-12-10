import {Router} from "express";
import {makeError, makeSuccess} from "../utils/BaseResponse";
import {AppDataSource} from "../services/dbService";
import DocumentEntity from "../entity/DocumentEntity";
import {UserModel} from "../entity/UserModel";
import {body, validationResult} from "express-validator";
import AppUtils, {tryParseInt} from "../utils/AppUtils";
import UserViewDocumentEntity from "../entity/UserViewDocumentEntity";

const router = Router()
const documentRepository = AppDataSource.getRepository(DocumentEntity)
const userRepository = AppDataSource.getRepository(UserModel)
const userViewDocRepo = AppDataSource.getRepository(UserViewDocumentEntity)

router.get("/detail/:id",
  async (req, res) => {
    const docId = tryParseInt(req.params.id, -1)
    const user: UserModel = req.body["performer"]

    const document = await documentRepository.findOne({
      where: {
        id: docId
      },
    })

    if (document) {
      return makeSuccess(res, document)
    }

    return makeError(res, 404, "No document with this id")
  })

router.get("/list/:id", async (req, res) => {
  try {
    const userId = tryParseInt(req.params.id, -1)

    const user = await userRepository.findOne({
      where: {
        id: userId
      },
      relations: {
        documents: true,
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
  async (req, res,) => {
    const errors = validationResult(req);
    const user: UserModel = req.body["performer"]

    if (!errors.isEmpty()) {
      return makeError(res, 404, AppUtils.getValidateError(errors))
    }

    try {
      const result = await documentRepository.save({
        title: req.body["title"],
        description: req.body["description"],
        download_url: req.body["download_url"],
        semester: req.body["semester"],
        uploader: user
      })

      return makeSuccess(res, result)
    } catch (e) {
      return makeError(res)
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
