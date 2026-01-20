# Personal Preferences

## Documentation & Note-Taking

I maintain an Obsidian vault at `~/dev/notes/` for documentation.

### Commands for capturing notes:
- **"Add to today"** or **"Document this for today"**: Append content to daily note at `~/dev/notes/Day/YYYY-MM-DD.md`
- **"Add to [Topic]"** or **"Document in [Topic]"**: Append content to topic note at `~/dev/notes/[Topic].md`

### What "this" refers to:
- The last code block, explanation, or command result you generated
- If I say "from clipboard", I'll paste the content first

### Format requirements:
- **Daily notes**:
  - Create file if it doesn't exist with title `# YYYY-MM-DD`
  - Append entries with timestamp header `## HH:MM` before content
  - Use proper markdown formatting

- **Topic notes**:
  - Create file if it doesn't exist with title `# [Topic]`
  - Append entries with date reference at the end: `*Documented: [[YYYY-MM-DD]]*`
  - Use proper markdown formatting

- **Always**:
  - Use Obsidian wikilink syntax: `[[page name]]` for internal links
  - Format code blocks with proper language tags
  - Preserve all formatting from the original content
