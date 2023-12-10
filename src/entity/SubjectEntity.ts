import BaseEntity from "./BaseEntity";
import {Column, Entity, ManyToOne} from "typeorm";
import SchoolEntity from "./SchoolEntity";

@Entity()
export default class SubjectEntity extends BaseEntity {
  @Column({unique: true})
  name: string

  @Column({unique: true})
  code: string

  @ManyToOne(() => SchoolEntity, model => model.subjects)
  school: SchoolEntity
}
