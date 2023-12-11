import BaseEntity from "./BaseEntity";
import {Column, Entity, ManyToOne, OneToMany} from "typeorm";
import SchoolEntity from "./SchoolEntity";
import DocumentEntity from "./DocumentEntity";

@Entity()
export default class SubjectEntity extends BaseEntity {
  @Column({unique: true})
  name: string

  @Column({unique: true})
  code: string

  @ManyToOne(() => SchoolEntity, model => model.subjects)
  school: SchoolEntity

  @OneToMany(() => DocumentEntity, model => model.lecturer)
  documents: DocumentEntity[]
}
