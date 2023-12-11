import BaseEntity from "./BaseEntity";
import {Column, Entity, ManyToOne, OneToMany} from "typeorm";
import SchoolEntity from "./SchoolEntity";
import DocumentEntity from "./DocumentEntity";

@Entity()
export default class LecturerEntity extends BaseEntity {
  @Column()
  name: string

  @Column({unique: true})
  profile_url: string

  @ManyToOne(() => SchoolEntity, model => model.lecturers)
  school: SchoolEntity

  @OneToMany(() => DocumentEntity, model => model.lecturer)
  documents: DocumentEntity[]
}
