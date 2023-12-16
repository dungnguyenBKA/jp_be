// Get the necessary packages
import express from 'express'
import bodyParser from 'body-parser'
import sourceMapSupport from 'source-map-support'
import auth from './controllers/authentication'
import users from './controllers/users'
import cors from 'cors'
import authenticateJWT from "./services/authService";
import document from "./controllers/document";
import category from "./controllers/category";
import school from "./controllers/school";
import lecturer from "./controllers/lecturer";
import subject from "./controllers/subject";

const app = express()

const {json, urlencoded} = bodyParser

// Typescript, CORS, and JSON Parsing support
sourceMapSupport.install()
app.use(cors());
app.use(json())
app.use(urlencoded({extended: false}))
app.use('/files', express.static('uploads'))

const router = express.Router()
router.use('/', auth)
router.use('/users', authenticateJWT, users)
router.use('/document', authenticateJWT, document)
router.use('/category', authenticateJWT, category)
router.use('/school', authenticateJWT, school)
router.use('/lecturer', authenticateJWT, lecturer)
router.use('/subject', authenticateJWT, subject)

// Routes
app.use("/api", router)

export default app
