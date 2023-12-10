import BaseEntity from "./BaseEntity";
import {Column, Entity, OneToMany} from "typeorm";
import SubjectEntity from "./SubjectEntity";
import LecturerEntity from "./LecturerEntity";

@Entity()
export default class SchoolEntity extends BaseEntity {
  @Column({unique: true})
  name: string

  @Column({unique: true})
  code: string

  @OneToMany(() => SubjectEntity, model => model.school)
  subjects: SubjectEntity[]

  @OneToMany(() => LecturerEntity, model => model.school)
  lecturers: LecturerEntity[]
}
