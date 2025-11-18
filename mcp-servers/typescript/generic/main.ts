import { McpServer, ResourceTemplate } from 'npm:@modelcontextprotocol/sdk/server/mcp.js'
import { StdioServerTransport } from "npm:@modelcontextprotocol/sdk/server/stdio.js";
import { z } from 'npm:zod';
import { readFileSync as read_file } from 'node:fs'

const server = new McpServer({
  name: 'Friendly Generic Project Builder',
  version: '1.0.0'
})

server.resource(
  'project-philosophy',
  'global://project-philosophy',
  async (uri) => ({
    contents: [{
      uri: uri.href,
      text: read_file(`/Users/xavierwallis/projects/wallis-toolkit/mcp-servers/typescript/generic/robot-bible.txt`, 'utf-8')
    }]
  })
)

const transport = new StdioServerTransport();
await server.connect(transport);
