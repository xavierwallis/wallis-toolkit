import { McpServer, ResourceTemplate } from 'npm:@modelcontextprotocol/sdk/server/mcp.js'
import { exec } from 'node:child_process';
import { promisify } from 'node:util';
import { StdioServerTransport } from "npm:@modelcontextprotocol/sdk/server/stdio.js";
import { z } from 'npm:zod';

const exec_async = promisify(exec);

const server = new McpServer({
  name: 'McpServer',
  version: '1.0.0'
})

server.tool(
  'tailscale-status',
  {},
  async () => {
    const { stdout } = await exec_async('tailscale status')
    return {
      content: [{
        type: 'text', // Use 'json' instead of 'text' for structured data
        text: stdout
      }]
    }
  }
)

server.tool(
  'tailscale-login',
  {},
  async () => {

  }
)

server.tool(
  'tailscale-up',
  {},
  async () => {

  }
)


server.tool(
  'tailscale-execute',
  { ip: z.string(), password: z.string() },
  async ({ ip, password }) => ({
    content: [{ type: "text", text: 'hi' }]
  })
)


const transport = new StdioServerTransport();
await server.connect(transport);
