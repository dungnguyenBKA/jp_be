import BaseEntity from "./BaseEntity";
import {Column, Entity, ManyToOne} from "typeorm";
import DocumentEntity from "./DocumentEntity";

@Entity()
export default class FileEntity extends BaseEntity {
  @Column({unique: true})
  url: string

  @ManyToOne(() => DocumentEntity, model => model.files)
  document: DocumentEntity
}
