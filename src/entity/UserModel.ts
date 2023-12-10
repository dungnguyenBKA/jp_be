import {Column, Entity, ManyToMany, OneToMany} from "typeorm"
import BaseEntity from "./BaseEntity";
import DocumentEntity from "./DocumentEntity";
import CommentEntity from "./CommentEntity";

@Entity()
export class UserModel extends BaseEntity {
  @Column({nullable: false, unique: true})
  email: string

  @Column({nullable: false})
  full_name: string

  @Column()
  password: string

  @Column()
  avatar: string

  @Column({default: "user"})
  role: "admin" | "user"

  @OneToMany(() => DocumentEntity, (model) => model.uploader)
  documents: DocumentEntity[]

  @ManyToMany(() => DocumentEntity, (model) => model.likedUsers)
  favouriteDocuments: DocumentEntity[]

  @OneToMany(() => CommentEntity, (model) => model.author)
  comments: CommentEntity[]
}
