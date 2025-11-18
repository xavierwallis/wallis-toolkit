import { McpServer, ResourceTemplate } from 'npm:@modelcontextprotocol/sdk/server/mcp.js'
import { StdioServerTransport } from "npm:@modelcontextprotocol/sdk/server/stdio.js";

const server = new McpServer({
  name: 'McpServer',
  version: '1.0.0'
})

server.tool(
  'ding',
  async () => {
    const sound = new Deno.Command( "afplay", { args: ["ding.mp3"] } )
    await sound.output()
    const notification = new Deno.Command("osascript", { args: ["-e", `display notification "ding!" with title "Notification"`] } )
    await notification.output()
    return {
      content: [
        { type: "text", text: 'ding!' }
      ]
    }
  }
)

const transport = new StdioServerTransport();
await server.connect(transport);
