use strict;

import { type NextRequest, NextResponse } from 'next/server'
//import { update_session } from @/utils/supabase/middleware;

export async function middleware(request: NextRequest) {
  // update user's authentication session
  // this can be done with auth.js or manually through cookies 
  //
  return NextResponse.next()
}
