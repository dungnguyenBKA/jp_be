import BaseEntity from "./BaseEntity";
import {Entity, OneToOne} from "typeorm";
import DocumentEntity from "./DocumentEntity";
import {UserModel} from "./UserModel";

@Entity()
export default class UserViewDocumentEntity extends BaseEntity {
  // @OneToOne(() => DocumentEntity)
  // document: DocumentEntity
  //
  // @OneToOne(() => UserModel)
  // user: UserModel
}
