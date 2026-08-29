# Personal Preferences

## About me

Company: Datadog
Personal ID: javier.santacruz
Personal email: javier.santacruz@datadoghq.com
Team name: Deployment Gates
Team Github id: @ddoghq/deployment-gates

## Communication

**Always respond in English**, even if I write to you in Spanish, unless I explicitly request a response in Spanish.

**Be concise and professional:**

- Avoid jargon, use plain words and simple terms.
- Answers should aim to 50 words, be schematic and to the point.
- Avoid emojis, dashes `–` and fancy separators in documents.
- Include simple text diagrams to explain relationships of more than 3 elements, flows,
  interactions, timelines.
- When presenting a rich text, or markdown render in the console, always include links as clickable
  objects. 

## Knowledge Base

I keep `/notes` for my vault at `~/dev/notes` for personal knowledge. I refer to these as "my
notes" or "mis notas". Use `/obsidian` to edit it.
Use `/confluence` for Datadog company instructions, documentation, technical info, service descriptions, mitigation guidelines, runbooks.
Use `/jira` to work tracking, past tickets and issues, for planification and task management.
Use google workspace to search for Datadog documents, presentations, and spreadsheets, shared docs.

## CLI Tool Preferences

**Prefer CLI tools over MCP servers when available:**

CLI tools are faster, more reliable, and easier to script. Only use MCP servers when CLI alternatives don't exist or are insufficient.

- **GitHub:** Use `gh` CLI instead of GitHub MCP. 
- **Jira:** Use `/jira` skill
- **Confluence:** Use `/confluence` skill
- **AWS:** Use `aws-vault` see `/aws-vault` skill
- **Datadog internal infra (Vault, ISA tokens, GitHub/GitLab tokens):** Use `ddtool auth` — see `/ddtool` skill
- **Datadog API, ad-hoc (curl/dogshell/scripts):** Use `dd-auth` — see `/dd-auth` skill
- **Datadog API, full CLI:** Use `pup` — see `/pup` skill
- **Datadog releases/deploys:** Use `ddr` commands as needed
- **Slack:** Use `slack` cli command
- Use `/docus` to explore any unfamiliar CLI tool before planning how to use it.

If any of the tools requires authentication — including `aws-vault`, `ddtool auth`, `dd-auth`,
`pup auth` — run the auth command right away without asking for confirmation first. These open a
browser, MFA prompt, or Keychain dialog that I handle interactively; you don't need to wait for
or ask about that. Re-run the auth command again mid-task if a token expires — no need to ask.

# Work Preferences

Most development for existing services and applications will happen under the ~/dd directory.

See my notes for ~/dev/notes/IA/New Development Task.md

When creating any branch in a repository under the ~/dd directory, always:

- **Use the branch name convention**: <prefix>/<jira-id>-short-description
- My prefix is: jvrsantacruz
- The Jira Case is something you need to ask the developer about when in doubt
- **Do not include Claude references in commit messages**: Never ever add the Co-Authored-By:
  Claude Sonnet signature to a commit message.

## Testing Before Pushing

**Always run the test suite before pushing to any repository.**

- Run `make test` (or equivalent) before every `git push`
- If the repo has a `pre-commit` hook, verify it passes before committing
- Never push with failing tests — fix them first or explicitly ask the user how to proceed
- If `make test` is slow, at minimum run tests for files you changed: `uv run pytest tests/test_<affected>.py`

## Github Pull Requests

- ALWAYS **Use the Pull Request name convention**: The PR format in github follows a convention,
  title should be something like `[SDCD-2151] add duration to AI rule`  with format being
  `[<jira-id>] <ticket short title>`
- SHOULD create pull requests as DRAFT to avoid automatic reviewer assignment. Set it to "Ready to review" after user validates.
- SHOULD write pull request descriptions that are short businnes high level executive resume
  stating intention aimed to 50 words, always under 200 words. Include a flow chart when the task
  changes an existing workflow. Include a sequence diagram if we're affecting service calls. Do NOT 
  add a `Test Plan` section unless the task requires manual steps by humans.
- ALWAYS isolate the work for a new change in a worktree, create a worktree off main/master from
  the repository and then stick to make the changes there to avoid polluting other changes. Do not
  create branches and change code in main branch of the repository.

- NEVER use `Datadog/dd-source`, `Datadog/dogweb`, or `Datadog/dd-go` GitHub URLs: the `Datadog` org
  is deprecated and under migration (the repos and local clones themselves are fine and actively
  used). Use the `ddoghq` org URL instead, with the `javier-santacruz_ddog` account. Switch accounts
  with `gh auth switch --user <account>`.
- ALWAYS When mentioning an existing Pull Request always include the URL link for easy access.
- NEVER reply to/resolve GitHub review comments without my explicit OK this conversation. Fix the
  code, show me the comment + proposed reply, wait. (`@codex review`/`@autotest review` triggers are fine.)

The complete workflow for a Pull Request for a Datadog repository is:

1. Create the Pull Request as DRAFT
2. Push the code
3. Trigger codex automatic review adding a note with content: "@codex review"
3. Trigger autotest automatic review adding a note with content: "@autotest review"
4. Wait for CI checks and reviews to complete
5. Address any feedback from Codex or Autotest
6. Wait for user to authorize marking "Ready for review" once all checks pass and user validates

## Architecture & Code Quality

Use the `arch` skill for structural and code quality decisions: reviews, module and service
design, choosing between architectures, ADRs and RFCs, migrations and rollouts. Skip it for
single-file edits, bug fixes, prototypes and one-off scripts.

## Architecture Decision Records

When making significant architectural decisions in a project that has `./docs/decisions/`, proactively suggest using `/adr` to document it.

## Worktree Management

Use the `EnterWorktree` tool to create all worktrees (Jira tasks, experiments, everything). It places them under `.claude/worktrees/`, which `workon` already understands.

- Branch naming convention: `jvrsantacruz/<JIRA-ID>-short-description`
- Always branch from the main branch of the relevant repo under `~/dd/`
- When mentioning an existing JIRA ticket always include the URL link for easy access.

## Dev Personal Workspace

Use `/workspace` to create a personal dev workspace for one-off code, scripts, and experiments.

## Project Navigation

Use `workon <name>` to navigate to any project — it covers `~/dev`, `~/dd`, workspaces, and `.claude/worktrees`. Use `workon --list` to enumerate all of them. Prefer this over bare `cd` paths when suggesting navigation.

## Document rendering

## Slack — CRITICAL RULE

**UNDER NO CIRCUMSTANCES send any Slack message, reaction, or DM without the user's explicit permission in the current conversation.**
This applies to all write operations via the `slack` CLI: `slack slack-send-message`, `slack slack-schedule-message`, `slack slack-send-message-draft`, canvas writes, and any other write subcommand.
Always show the message content and recipient first and wait for explicit approval before sending. No exceptions.

Use `/slack` skill for Slack operations.
