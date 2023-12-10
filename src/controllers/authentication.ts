import {Request, Response, Router} from 'express'
import utils from '../services/passwordService'
import {AppDataSource} from '../services/dbService'
import {body, validationResult} from 'express-validator'
import {Repository} from 'typeorm'
import {generateJWT} from '../services/authService'
import {UserModel} from "../entity/UserModel";
import {makeError, makeSuccess} from "../utils/BaseResponse";

const router = Router()
const userRepository: Repository<UserModel> = AppDataSource.getRepository(UserModel)

// Authentication
router.post('/login', async function (request, response) {
  try {
    const user = await userRepository.findOne({
      where: {email: request.body.email},
    })


    if (!user) {
      return makeError(response, 404, msgNoUserFound)
    }

    // Check the password now
    const isSame = await utils.compareHash(request.body.password, user.password)
    const access_token = generateJWT(user)
    if (!isSame) {
      return response.status(403).send({
        message: msgWrongPassword
      })
    }

    const _userRes: Partial<UserModel> = user;
    delete _userRes['password']

    // Otherwise return payload
    makeSuccess(response, {
      access_token, user: _userRes,
    })
  } catch (error) {
    makeError(response, 500)
  }
})

// Signup
router.post('/signup', body('email').isEmail(), body('password').isLength({min: 8}), async function (request: Request, response: Response,) {
  // Handle missing fields
  const errors = validationResult(request);
  if (!errors.isEmpty()) {
    return makeError(response, 400, JSON.stringify(errors.array()[0]))
  }

  // Inserting the row into the DB, but hash password first
  utils.hashPassword(request.body.password)
    .then(async hash => {
      request.body.password = hash
      request.body.role = "user"
      let user: Omit<UserModel, "password"> = await userRepository.save(request.body)
      const access_token = generateJWT(user)
      const _userRes: Partial<UserModel> = user;
      delete _userRes['password']
      makeSuccess(response, {
        access_token, user: _userRes,
      }, msgSignupSuccess,);
    }).catch(err => {
    makeError(response, 500, JSON.stringify(err))
  })
})

const msgSignupSuccess = 'Account created successfully!'
const msgNoUserFound = "Authentication failed, no User found"
const msgLoginSuccess = "Logged in successfully!"
const msgWrongPassword = "Authentication failed, password do not match"

export default router
