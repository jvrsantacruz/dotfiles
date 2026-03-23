# Personal Preferences

## Language Preference

**Always respond in English**, even if I write to you in Spanish, unless I explicitly request a response in Spanish.

## Communication Style

**Be concise and professional:**
- Brief explanations when helpful, but avoid being verbose
- No excessive enthusiasm or emojis
- No lengthy introductions or wrap-ups
- State what you're doing, do it, confirm it's done
- Keep responses focused and practical

## CLI Tool Preferences

**Prefer CLI tools over MCP servers when available:**
- **GitHub:** Use `gh` CLI instead of GitHub MCP
- **Jira:** Use `acli` (Atlassian CLI) for Jira operations
- **Confluence:** Use Atlassian MCP (acli has limited Confluence support - no search capability)
- **Datadog:** Use `dd-auth`, `dog`, `ddr`, `pup` commands as needed

CLI tools are faster, more reliable, and easier to script. Only use MCP servers when CLI alternatives don't exist or are insufficient.

**Jira CLI (acli) commands:**
```bash
acli jira issue list
acli jira issue view SDCD-1234
acli jira issue create
```

**Confluence:** Always use Atlassian MCP for search, page reading, and page creation.

# Work Preferences

Most development for existing services and applications will happen under the ~/dd directory.

See my notes for ~/dev/notes/AI/New Development Task.md

When creating any branch in a repository under the ~/dd directory, always:

- **Use the branch name convention**: <prefix>/<jira-id>-short-description
- My prefix is: jvrsantacruz
- The Jira Case is something you need to ask the developer about when in doubt
- **Do not include Claude references in commit messages**: Never ever add the Co-Authored-By:
  Claude Sonnet signature to a commit message.

## Github Pull Requests

- **Use the Pull Request name convention**: The PR format in github follows a convention, título should be something like `[SDCD-2151] add duration to AI rule`  with format being `[<jira-id>] <ticket short title>`
- Write short, clear, precise but terse and to the point body descriptions when creating Pull
  Requests. Do not add a `Test Plan` section unless explicitly part of the task.

## Dev Personal Workspace

For new code, scripts, tests, and other development that is not directly related with updating or
modifying the code of an existing service under the ~/dd directory, we use the ~/dev directory.

- Always create a ~/dev/workspace/<YYYY-MM-DD>-<topic> directory before
- Create all code, data output, log files, inner docs in that directory

## Documentation & Note-Taking

I maintain an Obsidian vault at `~/dev/notes/` for documentation.
I refer to these as "my notes" or "mis notas" and always refer to them when I mention it.
When working with Obsidian notes, always read the `~/dev/notes/CLAUDE.md` file for instructions on how to work with that Vault.
When writting markdown text to a Vault, always preview it for acceptance.
Always use the obsidian MCP server to interact with the notes whenever possible.

## Document rendering

When presenting a rich text, or markdown render in the console, always include links as clickable
objects.
Always include by default a "References" section and the end of the document with the raw links so
I can copy/paste them and interact with them or save them.

## Google Drive Access

These are referred to as "the documents" or "google docs".
My Google Drive is mounted at: ~/Library/CloudStorage/GoogleDrive-javier.santacruz@datadoghq.com/
You can read any documents there using standard file tools.
Keep in mind that this is a network storage unit and can take really long to interact with the
contents of the files.

Note: Native Google Docs (.gdoc, .gsheet) are shortcuts and cannot be read directly.
Readable formats: PDF, .xlsx, .docx, .txt, .md
