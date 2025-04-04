import { NextRequest, NextResponse } from next/server;

export async function GET(request: NextRequest) {
  { /* if required handle necessary authentication */ }
  // example: const session = auth( request )

  { /* if required initiate/call database singleton */ }
  // example: const supabase = create_server()

  { /* if required unpack json or formdata */ }
  // example: const { user } = await request.json()

  { /* retrieve data contextually, retuning success or fail responses on completion/error */ }
  // example: if ( error  ) return NextResponse.error();
  return NextResponse.json({ status: 200 });
}

export async function POST(request: NextRequest) {

  { /* if required handle necessary authentication */ }
  // example: const session = auth( request )

  { /* if required initiate/call database singleton */ }
  // example: const supabase = create_server()

  { /* if required unpack json or formdata */ }
  // example: const { user } = await request.json()

  { /* update data contextually, retuning success or fail responses on completion/error */ }
  // example: if ( error  ) return NextResponse.error();
  return NextResponse.json({ status: 200 });
}
