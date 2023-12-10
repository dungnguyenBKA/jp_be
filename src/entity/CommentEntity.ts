import BaseEntity from "./BaseEntity";
import {Column, Entity, ManyToOne} from "typeorm";
import {UserModel} from "./UserModel";
import DocumentEntity from "./DocumentEntity";

@Entity()
export default class CommentEntity extends BaseEntity {
  @Column()
  content: string

  @ManyToOne(() => UserModel, model => model.comments)
  author: UserModel

  @ManyToOne(() => DocumentEntity, model => model.comments)
  document: DocumentEntity
}
