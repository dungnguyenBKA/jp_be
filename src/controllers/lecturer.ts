import {Router} from "express";
import {makeError, makeErrorInCatch, makeSuccess} from "../utils/BaseResponse";
import {AppDataSource} from "../services/dbService";
import {UserModel} from "../entity/UserModel";
import {body, validationResult} from "express-validator";
import AppUtils, {tryParseInt} from "../utils/AppUtils";
import LecturerEntity from "../entity/LecturerEntity";
import SchoolEntity from "../entity/SchoolEntity";

const router = Router()
const lecturerEntityRepository = AppDataSource.getRepository(LecturerEntity)
const schoolEntityRepository = AppDataSource.getRepository(SchoolEntity)

router.get("/detail/:id",
  async (req, res) => {
    try {
      const id = tryParseInt(req.params.id, -1)
      const lecturer = await lecturerEntityRepository.findOne({
        where: {
          id
        },
      })

      if (lecturer) {
        return makeSuccess(res, lecturer)
      }
      return makeError(res, 404, "No lecturer with this id")
    } catch (e) {
      return makeError(res, 400, JSON.stringify(e))
    }
  })

router.get("/list", async (req, res) => {
  try {
    const list = await lecturerEntityRepository.find()
    return makeSuccess(res, list)
  } catch (e) {
    return makeErrorInCatch(res, e)
  }
})

router.post("/create",
  body("name").notEmpty(),
  body("profile_url").notEmpty(),
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

      const result = await lecturerEntityRepository.save({
        name: req.body['name'],
        profile_url: req.body['profile_url'],
        school: school
      })

      return makeSuccess(res, result)
    } catch (e) {
      return makeErrorInCatch(res, e)
    }
  },
)

export default router
