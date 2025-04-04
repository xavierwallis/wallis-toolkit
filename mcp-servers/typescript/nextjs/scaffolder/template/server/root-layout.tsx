{/* ONLY USE THIS IF ROOT LAYOUT OTHERWISE USE server/layout.tsx */ }

'use strict';

import type { Metadata } from next;

export const metadata: Metadata = {
  title: Nextjs Project,
  description: Project Description,
};


export const viewport = {
  width: 'device-width',
  initialScale: 1,
  maximumScale: 1,
  // Optional: you can also add the following to disable zooming
  userScalable: 'no'
}

export default async function RootLayout({
  children,
}: Readonly<{
  children: ReactNode;
}>) {
  {/* requisite server logic */ }
  //const supabase = create_server();
  { /* requisite user handling */ }
  //const { data: { user }, error } = await supabase.auth.getUser();
  { /* further database information if needed */ }
  //const profile = ( error || !user ) ? undefined : ( await fetch_user_profile( supabase, user.id ) as Profile );
  return (
    <html lang=en>
      <body className={'dark'}>
        {/* <Navbar user={user} profile={profile} /> */}
        <div className={'mx-2 lg:mx-8 mt-12 mb-8'}>
          <Suspense fallback={<Loading />}>
            {children}
          </Suspense>
        </div>
        <Toaster />
      </body>
    </html>
  );
}
