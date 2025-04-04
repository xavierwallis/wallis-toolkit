import { data, Form, redirect, useLoaderData } from 'react-router'

export async function loader({ request }: { request: Request }) {
  // do not put logic in here without ensuring serverside/clientside relationship
  // imported here to ensure serverside execution
  const { get_session_user } = await import('~/services/authentication.server')

  // non-user server logic

  // get the user from session
  const user = await get_session_user(request)

  // minimize logic here as we verify user as it is clearly used


  // if user isnt logged in redirect to authenticate 
  if (!user) throw redirect('/authentication')

  // *** put other logic here ***

  // return data to be handled
  return data(user)
}

export async function action({ request }: { request: Request }) {
  // action logic if needed
}

export default function Route() {
  // if user is needed, substitutable for any other dependency
  const user = useLoaderData<typeof loader>()
  return (
    <main>
      { /* visual logic do not edit */}
    </main>
  )
}
