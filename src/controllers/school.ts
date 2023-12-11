import {Router} from "express";
import {makeError, makeErrorInCatch, makeSuccess} from "../utils/BaseResponse";
import {AppDataSource} from "../services/dbService";
import {UserModel} from "../entity/UserModel";
import {body, validationResult} from "express-validator";
import AppUtils, {tryParseInt} from "../utils/AppUtils";
import CategoryEntity from "../entity/CategoryEntity";
import LecturerEntity from "../entity/LecturerEntity";
import SchoolEntity from "../entity/SchoolEntity";

const router = Router()
const schoolEntityRepository = AppDataSource.getRepository(SchoolEntity)

router.get("/detail/:id",
  async (req, res) => {
    try {
      const id = tryParseInt(req.params.id, -1)
      const school = await schoolEntityRepository.findOne({
        where: {
          id
        },
      })

      if (school) {
        return makeSuccess(res, school)
      }
      return makeError(res, 404, "No school with this id")
    } catch (e) {
      return makeError(res, 400, JSON.stringify(e))
    }
  })

router.get("/list", async (req, res) => {
  try {
    const list = await schoolEntityRepository.find()
    return makeSuccess(res, list)
  } catch (e) {
    return makeErrorInCatch(res, e)
  }
})

router.get("/:school_id/list-lecturer", async (req, res) => {
  try {
    const id = tryParseInt(req.params.school_id, -1)

    const school = await schoolEntityRepository.findOne({
      where: {
        id
      },
      relations: {
        lecturers: true
      }
    })
    return makeSuccess(res, school?.lecturers)
  } catch (e) {
    return makeErrorInCatch(res, e)
  }
})

router.get("/:school_id/list-subject", async (req, res) => {
  try {
    const id = tryParseInt(req.params.school_id, -1)

    const school = await schoolEntityRepository.findOne({
      where: {
        id
      },
      relations: {
        subjects: true
      }
    })
    return makeSuccess(res, school?.subjects)
  } catch (e) {
    return makeErrorInCatch(res, e)
  }
})

router.post("/create",
  body("name").notEmpty(),
  body("code").notEmpty(),
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
      const result = await schoolEntityRepository.save({
        name: req.body['name'],
        code: req.body['code'],
      })

      return makeSuccess(res, result)
    } catch (e) {
      return makeErrorInCatch(res, e)
    }
  },
)

export default router
