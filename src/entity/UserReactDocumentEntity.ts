import BaseEntity from "./BaseEntity";
import {Column, Entity, ManyToOne} from "typeorm";
import DocumentEntity from "./DocumentEntity";
import {UserModel} from "./UserModel";

@Entity()
export default class UserReactDocumentEntity extends BaseEntity {
  @Column()
  vote: boolean

  @ManyToOne(() => UserModel, model => model.userReactDocuments)
  author: UserModel

  @ManyToOne(() => DocumentEntity, model => model.userReactDocuments)
  document: DocumentEntity
}
