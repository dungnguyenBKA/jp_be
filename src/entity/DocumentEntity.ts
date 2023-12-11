import BaseEntity from "./BaseEntity";
import {Column, Entity, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany} from "typeorm";
import {UserModel} from "./UserModel";
import CommentEntity from "./CommentEntity";
import CategoryEntity from "./CategoryEntity";
import UserViewDocumentEntity from "./UserViewDocumentEntity";
import LecturerEntity from "./LecturerEntity";
import SubjectEntity from "./SubjectEntity";

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
  @JoinTable()
  likedUsers: UserModel[]

  @ManyToMany(() => CategoryEntity, model => model.documents)
  @JoinTable()
  categories: CategoryEntity[]

  @OneToMany(() => UserViewDocumentEntity, model => model.document)
  userViewDocuments: UserViewDocumentEntity[];

  @ManyToOne(() => LecturerEntity, model => model.documents)
  lecturer: LecturerEntity

  @ManyToOne(() => SubjectEntity, model => model.documents)
  subject: SubjectEntity
}
