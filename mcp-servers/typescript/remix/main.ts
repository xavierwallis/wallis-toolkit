import { McpServer, ResourceTemplate } from 'npm:@modelcontextprotocol/sdk/server/mcp.js'
import { StdioServerTransport } from "npm:@modelcontextprotocol/sdk/server/stdio.js";
import { z } from 'npm:zod';
import { readFileSync as read_file } from 'node:fs';
import { exec, spawn } from 'node:child_process'
import { promisify } from 'node:util'

const exec_async = promisify(exec)

const server = new McpServer({
  name: 'Remix/ReactRouterV7 Scaffolder',
  version: '1.0.0'
})

enum resources {
  database_declaration,
  database_schema,
  route,
  protected_route,
  authentication,
  authentication_google,
  authentication_google_callback,
  plaid_link,
  plaid_link_token_create,

  authenticator
}

const resource_links = [
  'scaffolder://scaffolding/remix/database/declaration',
  'scaffolder://scaffolding/remix/database/schema',

  'scaffolder://scaffolding/remix/routes/route',
  'scaffolder://scaffolding/remix/routes/protected/route',
  'scaffolder://scaffolding/remix/routes/authentication',
  'scaffolder://scaffolding/remix/routes/authentication/google',
  'scaffolder://scaffolding/remix/routes/authentication/google/callback',
  'scaffolder://scaffolding/remix/routes/plaid/link',
  'scaffolder://scaffolding/remix/routes/plaid/link/token/create',

  'scaffolder://scaffolding/remix/services/authenticator',
]

const scaffolding_path = '/Users/xavierwallis/projects/wallis-toolkit/mcp-servers/typescript/remix/scaffolding'

server.resource(
  'database-declaration',
  resource_links[resources.database_declaration],
  async (uri) => ({
    contents: [{
      uri: uri.href,
      text: read_file(`${scaffolding_path}/database/declaration.ts`)
    }]
  })
)

server.resource(
  'database-schema',
  resource_links[resources.database_schema],
  async (uri) => ({
    contents: [{
      uri: uri.href,
      text: read_file(`${scaffolding_path}/database/schema.ts`)
    }]
  })
)

server.resource(
  'route',
  resource_links[resources.route],
  async (uri) => ({
    contents: [{
      uri: uri.href,
      text: read_file(`${scaffolding_path}/routes/route.tsx`)
    }]
  })
)

server.resource(
  'protected-route',
  resource_links[resources.protected_route],
  async (uri) => ({
    contents: [{
      uri: uri.href,
      text: read_file(`${scaffolding_path}/routes/protected/route.tsx`)
    }]
  })
)

server.resource(
  'authentication-route',
  resource_links[resources.authentication],
  async (uri) => ({
    contents: [{
      uri: uri.href,
      text: read_file(`${scaffolding_path}/routes/authentication/authentication.tsx`)
    }]
  })
)

server.resource(
  'authentication-google-route',
  resource_links[resources.authentication_google],
  async (uri) => ({
    contents: [{
      uri: uri.href,
      text: read_file(`${scaffolding_path}/routes/authentication/authentication.google.tsx`)
    }]
  })
)

server.resource(
  'authentication-google-callback-route',
  resource_links[resources.authentication_google_callback],
  async (uri) => ({
    contents: [{
      uri: uri.href,
      text: read_file(`${scaffolding_path}/routes/authentication/authentication.google.callback.tsx`)
    }]
  })
)

server.resource(
  'plaid-link-token-create-route',
  resource_links[resources.plaid_link_token_create],
  async (uri) => ({
    contents: [{
      uri: uri.href,
      text: read_file(`${scaffolding_path}/routes/plaid/plaid.link.token.create.tsx`)
    }]
  })
)

server.resource(
  'plaid-link-route',
  resource_links[resources.plaid_link],
  async (uri) => ({
    contents: [{
      uri: uri.href,
      text: read_file(`${scaffolding_path}/routes/plaid/plaid.link.tsx`)
    }]
  })
)

server.resource(
  'authenticator',
  resource_links[resources.authenticator],
  async (uri) => ({
    contents: [{
      uri: uri.href,
      text: read_file(`${scaffolding_path}/services/authenticator.ts`)
    }]
  })
)

// resource tool

server.tool(
  'list-resources',
  {},
  async () => ({
    content: [{ type: "text", text: resource_links.join('\n') }]
  })
)


// scaffolding tools

server.tool(
  'build-remix-app',
  { project_name: z.string() },
  async ({ project_name }: { project_name: string }) => {

    const child = spawn('npx', ['create-react-router@latest', project_name], {
      stdio: 'pipe'
    })

    child.stdin.write('\n')

    return new Promise((resolve, reject) => {
      child.on('close', (code) => {
        if (code !== 0) reject(new Error('process exited in error'))
        return {
          content: [{
            type: 'text',
            text: `created latest react router v7 project in ${project_name}`
          }]
        }
      })
    })
  }
)

server.tool(
  'build-database',
  { project_path: z.string() },
  async ({ project_path }: { project_path: string }) => {
    const ignored = await exec_async(`cp -r /Users/xavierwallis/projects/wallis-toolkit/mcp-servers/typescript/remix/scaffolding/database ${project_path}/src`)
    return {
      content: [{
        type: 'text',
        text: `moved ~/project/wallis-toolkit/mcp-servers/typescript/remix/scaffolding/database into ${project_path}/src containing children declaration.ts, schema.ts`
      }]
    }
  }
)

server.tool(
  'build-authentication-service',
  { project_path: z.string() },
  async ({ project_path }: { project_path: string }) => {
    const ignored = await exec_async(`cp -r /Users/xavierwallis/projects/wallis-toolkit/mcp-servers/typescript/remix/scaffolding/services ${project_path}/src`)
    return {
      content: [{
        type: 'text',
        text: `moved ~/project/wallis-toolkit/mcp-servers/typescript/remix/scaffolding/services into ${project_path}/src containing children authenticator.ts`
      }]
    }
  }
)

const transport = new StdioServerTransport();
await server.connect(transport);
