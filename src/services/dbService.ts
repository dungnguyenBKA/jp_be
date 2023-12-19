import 'reflect-metadata'
import {DataSource} from 'typeorm'
import {UserModel} from "../entity/UserModel";
import DocumentEntity from "../entity/DocumentEntity";
import CategoryEntity from "../entity/CategoryEntity";
import SchoolEntity from "../entity/SchoolEntity";
import SubjectEntity from "../entity/SubjectEntity";
import LecturerEntity from "../entity/LecturerEntity";
import CommentEntity from "../entity/CommentEntity";
import UserViewDocumentEntity from "../entity/UserViewDocumentEntity";
import FileEntity from "../entity/FileEntity";
import UserReactDocumentEntity from "../entity/UserReactDocumentEntity";

export const AppDataSource = new DataSource({
  type: process.env.TYPEORM_TYPE as any,
  host: process.env.TYPEORM_HOST,
  port: Number(process.env.TYPEORM_PORT),
  username: process.env.TYPEORM_USERNAME,
  password: process.env.TYPEORM_PASSWORD,
  database: process.env.TYPEORM_DATABASE,
  synchronize: Boolean(process.env.TYPEORM_SYNCHRONIZE),
  logging: process.env.TYPEORM_LOGGING as any,
  entities: [
    UserModel,
    DocumentEntity,
    CategoryEntity,
    SchoolEntity,
    SubjectEntity,
    LecturerEntity,
    CommentEntity,
    UserViewDocumentEntity,
    FileEntity,
    UserReactDocumentEntity,
  ],
  migrations: [],
  subscribers: []
})
export const initializeDatabase = async function () {
  try {
    if (!AppDataSource.isInitialized) {
      await AppDataSource.initialize()
      console.log('Database connection initialized')
    }
  } catch (error) {
    console.log(error)
  }
}
