import {Router} from "express";
import {makeError, makeErrorInCatch, makeSuccess} from "../utils/BaseResponse";
import {AppDataSource} from "../services/dbService";
import {UserModel} from "../entity/UserModel";
import {body, validationResult} from "express-validator";
import AppUtils, {tryParseInt} from "../utils/AppUtils";
import CategoryEntity from "../entity/CategoryEntity";
import LecturerEntity from "../entity/LecturerEntity";
import SchoolEntity from "../entity/SchoolEntity";
import SubjectEntity from "../entity/SubjectEntity";

const router = Router()
const subjectEntityRepository = AppDataSource.getRepository(SubjectEntity)
const schoolEntityRepository = AppDataSource.getRepository(SchoolEntity)

router.get("/detail/:id",
  async (req, res) => {
    try {
      const id = tryParseInt(req.params.id, -1)
      const subject = await subjectEntityRepository.findOne({
        where: {
          id
        },
      })

      if (subject) {
        return makeSuccess(res, subject)
      }
      return makeError(res, 404, "No lecturer with this id")
    } catch (e) {
      return makeError(res, 400, JSON.stringify(e))
    }
  })

router.get("/list", async (req, res) => {
  try {
    const list = await subjectEntityRepository.find()
    return makeSuccess(res, list)
  } catch (e) {
    return makeErrorInCatch(res, e)
  }
})

router.post("/create",
  body("name").notEmpty(),
  body("code").notEmpty(),
  body("school_id").isNumeric(),
  async (req, res,) => {
    const errors = validationResult(req);
    const user: UserModel = req.body["performer"]

    if (!errors.isEmpty()) {
      return makeError(res, 404, AppUtils.getValidateError(errors))
    }

    if (user.role === "user") {
      return makeError(res, 400, "Admin func only")
    }

    try {
      const school = await schoolEntityRepository.findOne({
        where: {
          id: req.body["school_id"]
        }
      })

      if (!school) {
        return makeError(res, 400, "School not found")
      }

      const result = await subjectEntityRepository.save({
        name: req.body['name'],
        code: req.body['code'],
        school: school
      })

      return makeSuccess(res, result)
    } catch (e) {
      return makeErrorInCatch(res, e)
    }
  },
)

export default router
