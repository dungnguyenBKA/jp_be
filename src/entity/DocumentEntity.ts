import BaseEntity from "./BaseEntity";
import {Column, Entity, JoinColumn, ManyToMany, ManyToOne, OneToMany} from "typeorm";
import {UserModel} from "./UserModel";
import CommentEntity from "./CommentEntity";
import CategoryEntity from "./CategoryEntity";

@Entity()
export default class DocumentEntity extends BaseEntity {
  @Column({nullable: false})
  title: string

  @Column({nullable: true})
  description: string

  @Column()
  download_url: string

  @Column({default: 0})
  download_count: number

  @Column({default: ""})
  semester: string

  @Column({default: false})
  is_verified: boolean

  @ManyToOne(() => UserModel, model => model.documents)
  @JoinColumn({name: "uploader_id"})
  uploader: UserModel

  @OneToMany(() => CommentEntity, model => model.document)
  comments: CommentEntity[]

  @ManyToMany(() => UserModel, model => model.favouriteDocuments)
  likedUsers: UserModel[]

  @ManyToMany(() => CategoryEntity, model => model.documents)
  categories: CategoryEntity[]
}
