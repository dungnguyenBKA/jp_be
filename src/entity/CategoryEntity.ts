import BaseEntity from "./BaseEntity";
import {Column, Entity, ManyToMany} from "typeorm";
import DocumentEntity from "./DocumentEntity";

@Entity()
export default class CategoryEntity extends BaseEntity {
  @Column({unique: true})
  name: string

  @ManyToMany(() => DocumentEntity, model => model.categories)
  documents: DocumentEntity[]
}
