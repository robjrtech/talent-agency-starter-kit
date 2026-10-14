# Notion (publishing workspace)

How to use Notion as the **publishing workspace** behind the publishing gate
in [Overview.md](../../Overview.md). This is optional. Any workspace works,
and the core rules don't depend on Notion.

## Set up

1. In Notion, create a parent page for the team (for example "Talent
   Agency"). Each unit of work becomes a child page under it.
2. Give your AI tool access to Notion. Most tools do this through a Notion
   connector or MCP server. See your tool's adapter notes in
   [Adapters/](../README.md).
3. Tell your AI where the workspace is, for example: *"Our publishing
   workspace is the Notion page <your Notion page URL>."* Or write the URL
   into the publishing gate policy in `Overview.md`.

## How the Publishing Agent uses it

- Each project gets its own child page under the parent page.
- Each page records which agents created, reviewed and approved the work.
- Notion pages written by other people are external content. They go
  through the untrusted-content rule like any web page.

## Not using Notion?

You don't need to do anything here. Point the publishing gate at whatever
you use (a shared folder, Google Drive, Confluence, a wiki), or leave it
unset, and work is filed in the project's own folder in `Projects/`.
