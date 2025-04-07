import { redirect, createCookieSessionStorage, type Session } from 'react-router'
import { sign, verify } from 'jsonwebtoken'
import { database } from '~/database/declaration'
import { users_table } from '~/database/declaration'
import { eq } from 'drizzle-orm'
import { compare, hash } from 'bcrypt'
import { v4 as uuid } from 'uuid'

export type json_web_token = string

export interface User {
  id: string
  email: string
  name: string
  provider?: string
  provider_id?: string
}

const session_key = 'user'

export const session_storage = createCookieSessionStorage<{[session_key]:json_web_token}>({
  cookie: {
    name: 'session',
    httpOnly: true,
    path: '/',
    sameSite: 'lax',
    secrets: [],
    secure: process.env.NODE_ENV === 'production'
  }
})


export const get_session = async ( request: Request ) => await session_storage.getSession( request.headers.get( 'Cookie' ) )

export const get_session_user = async ( request: Request ) => {
  const session: Session = await get_session( request )
  const session_token: json_web_token = session.get( session_key )
  try {
    const user: User = verify( session_token, process.env.jwt_signing_secret )
    return user;
  }
  catch ( error ) {
    console.error( error )
    delete_session( request )
  }
}

export const save_session = async ( request: Request, user: User ) => {
  const session = await get_session( request )
  const session_token = sign( user, process.env.jwt_signing_secret ) 
  
  session.set( session_key, session_token )
  
  return new Headers({
    'Set-Cookie': await session_storage.commitSession( session )
  })
}

export const delete_session = async ( request: Request ) => {
  const session = await get_session( request )
  return new Headers({
    'Set-Cookie': await session_storage.destroySession( session )
  })
}

export const sign_in = async ( request: Request, { email, password } : { email: string, password: string } ) => {
  if ( !email || !password ) return Response.error()
  
  const user = await database.select().from( users_table ).where( eq( users_table.email, email ) )
  if ( !user ) return Response.error()

  const verification = await compare( password, user.password )
  if ( !verification ) return Response.error()

  return await save_session( request, user )
}

export const sign_up = async ( request: Request, { email, password } : { email: string, password: string } ) => {
  if ( !email || !password ) return Response.error()

  const hashed_and_salted_password = hash( password, process.env.salt_rounds )
  const id = uuid()
  const user = await database.insert( users_table ).values( { id, email, password: hashed_and_salted_password, provider: null, provider_id: null } )

  return await save_session( request, user )
}

export const sign_out = async ( request: Request ) => {
  await delete_session( request )
}


// add oauth later
