import BaseEntity from "./BaseEntity";
import {Column, Entity, JoinColumn, ManyToOne} from "typeorm";
import {UserModel} from "./UserModel";

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
}
