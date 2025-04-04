import { ReactNode, Suspense } from 'react'
export async function Layout({ children }: { readonly children: ReactNode }) {
  {/* internal server logic using async await */ }

  return (
    <main>
      <Suspense> {/* suspsense if needed if not remove*/}
        {children}
      </Suspense>
    </main>
  )
}
