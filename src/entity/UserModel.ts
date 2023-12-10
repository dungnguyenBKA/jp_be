import {Column, Entity, OneToMany} from "typeorm"
import BaseEntity from "./BaseEntity";
import DocumentEntity from "./DocumentEntity";

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
  //
  // @ManyToMany(() => Conversation, (model) => model.users)
  // conversations: Conversation[]
  //
  // @OneToMany(() => ReadMessage, (model) => model.user)
  // reads: ReadMessage[]
}
