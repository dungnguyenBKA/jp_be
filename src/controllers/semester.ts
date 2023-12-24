import {Router} from "express";
import {makeError, makeErrorInCatch, makeSuccess} from "../utils/BaseResponse";
import {AppDataSource} from "../services/dbService";
import {UserModel} from "../entity/UserModel";
import {body, validationResult} from "express-validator";
import AppUtils from "../utils/AppUtils";
import SemesterEntity from "../entity/SemesterEntity";

const router = Router()
const semesterEntityRepository = AppDataSource.getRepository(SemesterEntity)

router.get("/list", async (req, res) => {
  try {
    const list = await semesterEntityRepository.find()
    return makeSuccess(res, list)
  } catch (e) {
    return makeErrorInCatch(res, e)
  }
})

router.post("/create",
  body("name").notEmpty(),
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
      const result = await semesterEntityRepository.save({
        name: req.body['name'],
      })

      return makeSuccess(res, result)
    } catch (e) {
      return makeErrorInCatch(res, e)
    }
  },
)

export default router
