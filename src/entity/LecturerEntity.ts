import BaseEntity from "./BaseEntity";
import {Column, Entity, ManyToOne} from "typeorm";
import SchoolEntity from "./SchoolEntity";

@Entity()
export default class LecturerEntity extends BaseEntity {
  @Column()
  name: string

  @Column({unique: true})
  profile_url: string

  @ManyToOne(() => SchoolEntity, model => model.lecturers)
  school: SchoolEntity
}
