import {Column, Entity} from "typeorm"
import BaseEntity from "./BaseEntity";

@Entity()
export class UserModel extends BaseEntity {
  @Column({nullable: false, unique: true})
  phone_number: string

  @Column({nullable: false})
  full_name: string

  @Column()
  password: string

  @Column()
  avatar: string

  // @OneToMany(() => Message, (model) => model.sender)
  // messages: Message[]
  //
  // @ManyToMany(() => Conversation, (model) => model.users)
  // conversations: Conversation[]
  //
  // @OneToMany(() => ReadMessage, (model) => model.user)
  // reads: ReadMessage[]
}
