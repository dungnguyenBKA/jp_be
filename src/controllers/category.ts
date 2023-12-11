import {Router} from "express";
import {makeError, makeErrorInCatch, makeSuccess} from "../utils/BaseResponse";
import {AppDataSource} from "../services/dbService";
import {UserModel} from "../entity/UserModel";
import {body, validationResult} from "express-validator";
import AppUtils, {tryParseInt} from "../utils/AppUtils";
import CategoryEntity from "../entity/CategoryEntity";

const router = Router()
const categoryRepository = AppDataSource.getRepository(CategoryEntity)

router.get("/detail/:id",
  async (req, res) => {
    try {
      const cateId = tryParseInt(req.params.id, -1)
      const user: UserModel = req.body["performer"]

      const category = await categoryRepository.findOne({
        where: {
          id: cateId
        },
      })

      if (category) {
        return makeSuccess(res, category)
      }
      return makeError(res, 404, "No category with this id")
    } catch (e) {
      return makeError(res, 400, JSON.stringify(e))
    }
  })

router.get("/list", async (req, res) => {
  try {
    const categoryEntities = await categoryRepository.find()
    return makeSuccess(res, categoryEntities)
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
      const result = await categoryRepository.save({
        name: req.body['name']
      })

      return makeSuccess(res, result)
    } catch (e) {
      return makeErrorInCatch(res, e)
    }
  },
)

export default router
