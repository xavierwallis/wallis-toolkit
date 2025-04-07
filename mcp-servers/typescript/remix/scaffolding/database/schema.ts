import { pgTable, text } from 'drizzle-orm/pg-core'
import { v4 as uuid } from 'uuid'

export const users_table = pgTable( 'users', {
  id: text().notNull().unique().primaryKey().default( uuid() ),
  email: text().notNull().unique(),
  password: text(),
  provider: text(),
  provider_id: text().unique(),
})
