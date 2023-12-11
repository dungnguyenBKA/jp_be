import BaseEntity from "./BaseEntity";
import {Entity, ManyToOne} from "typeorm";
import DocumentEntity from "./DocumentEntity";
import {UserModel} from "./UserModel";

@Entity()
export default class UserViewDocumentEntity extends BaseEntity {
  @ManyToOne(() => DocumentEntity, model => model.userViewDocuments)
  public document: DocumentEntity

  @ManyToOne(() => UserModel, model => model.userViewDocuments)
  public user: UserModel
}
