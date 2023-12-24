import BaseEntity from "./BaseEntity";
import {Column, Entity, ManyToMany, OneToMany} from "typeorm";
import DocumentEntity from "./DocumentEntity";

@Entity()
export default class SemesterEntity extends BaseEntity {
  @Column({unique: true})
  name: string

  @OneToMany(() => DocumentEntity, model => model.semester)
  documents: DocumentEntity[]
}
