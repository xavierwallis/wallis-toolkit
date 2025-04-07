import { drizzle } from 'drizzle-orm/node-postgres'

export const database = drizzle( process.env.database_url )
