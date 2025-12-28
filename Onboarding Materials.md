# 🎯 Intern Onboarding Materials

Welcome to the team! This guide will help you get started with all the tools and systems we use.

---

## 📋 Table of Contents
- [📱 Communication - Slack](#-communication---slack)
- [🎨 Collaboration - FigJam](#-collaboration---figjam)
- [📝 Knowledge Management - Obsidian](#-knowledge-management---obsidian)
- [📋 Spec-Driven Development - Spec Kit](#-spec-driven-development---spec-kit)
- [📄 API Specifications - OpenSpec](#-api-specifications---openspec)
- [🐧 Linux Basics (Optional)](#-linux-basics-optional)
- [🔀 Version Control - Git & GitHub](#-version-control---git--github)
- [🤖 AI Coding Assistants](#-ai-coding-assistants)
- [🐛 Debugging](#-debugging)
- [📊 Project Management - GitHub Projects](#-project-management---github-projects)
- [🔢 Mathematics for AI](#-mathematics-for-ai)

---

## 📱 Communication - Slack

Slack is our primary communication tool for team discussions, announcements, and quick questions.
### 📝 Daily Status Updates (Required)

**All interns are required to send a daily status update on Slack.**

#### When to Post
- Post your status update at **midday** (around 12:00 PM)
- If you're unable to work on a particular day, notify your supervisor in advance

#### What to Include
```
📅 Date: [Today's Date]

✅ What I've Finished:
- [Completed task 1]
- [Completed task 2]

🔄 What I'm Currently Working On:
- [Current task you're focused on]
- [Any ongoing work]

🚧 Blockers (if any):
- [Any issues preventing progress]
```

#### Why This Matters
- Keeps the team informed of your progress
- Helps identify blockers early so we can assist
- Builds accountability and time management skills
- Provides visibility for your contributions

> **Important:** Consistent daily updates are part of your internship evaluation. If you miss updates, your supervisor will follow up.

### Getting Started
1. Download Slack desktop app or use web version
2. Set up your profile with name and photo
3. Enable notifications for important channels
4. Learn shortcuts: `Ctrl+K` to quick switch channels

### 🔗 Resources & Links
| Resource        | Link                                        |
| --------------- | ------------------------------------------- |
| Video Tutorial  | https://www.youtube.com/watch?v=o3HJuPaITWk |



---

## 🎨 Collaboration - FigJam

FigJam is our whiteboarding and brainstorming tool for collaborative design thinking.

### What We Use It For
- Brainstorming sessions
- Workflow diagrams
- Sprint planning
- Retrospectives
- Mind mapping

### Getting Started
1. Create a Figma account (FigJam is included)
2. Request access to team workspace
3. Explore templates for common activities
4. Learn basic tools: sticky notes, shapes, connectors

### 🔗 Resources & Links
| Resource         | Link                                                                                     |
| ---------------- | ---------------------------------------------------------------------------------------- |
| Video Tutorial   | https://youtube.com/playlist?list=PLXDU_eVOJTx7yUfX46VEB3VafmkdNpZhq&si=_WTGqGTVWOhWkO_n |


---

## 📝 Knowledge Management - Obsidian

Obsidian is our knowledge management tool for documentation, notes, and project planning.

### What We Use It For
- Project documentation
- Meeting notes
- Technical specifications
- Knowledge base articles
- Personal note-taking

### Key Features
- **Markdown-based** - All notes are plain text files
- **Linking** - Connect related notes with `[[wiki links]]`
- **Graph view** - Visualize connections between notes
- **Templates** - Standardized formats for common documents
- **Plugins** - Extended functionality

### Getting Started
1. Download Obsidian from obsidian.md
2. Request access to team vault
3. Familiarize yourself with markdown syntax
4. Learn keyboard shortcuts: `Ctrl+O` to open files, `Ctrl+P` for command palette

### 🔗 Resources & Links
| Resource               | Link                                                              |
| ---------------------- | ----------------------------------------------------------------- |
| Team Vault Location    | https://github.com/Wider-Community/wider-community-obsidian-vault |
| Video Tutorial         | https://www.youtube.com/watch?v=z4AbijUCoKU                       |
| Claude Code + Obsidian | https://www.youtube.com/watch?v=a1FDaoF8Jog                       |


---

## 📋 Spec-Driven Development - Spec Kit

Spec Kit is a toolkit for Spec-Driven Development—a methodology that prioritizes creating detailed specifications before implementation.

### Why We Use It
- Focus on product scenarios and predictable outcomes
- Define requirements before jumping into code
- Multi-step refinement over single-prompt code generation
- Higher quality outputs for mission-critical projects

### Slash Commands
Once initialized in a project, you can use these commands with AI coding assistants:
- `/speckit.constitution` – Establish project principles
- `/speckit.specify` – Define requirements
- `/speckit.plan` – Create implementation strategies
- `/speckit.tasks` – Generate actionable task lists
- `/speckit.implement` – Execute the plan

### Supported AI Assistants
Works with 15+ coding assistants including:
- Claude
- GitHub Copilot
- Cursor
- Gemini
- Windsurf

### Getting Started
1. Install the Specify CLI (`specify`)
2. Initialize Spec Kit in your project
3. Follow the spec-driven workflow: Constitution → Specify → Plan → Tasks → Implement

### 🔗 Resources & Links
| Resource          | Link                                                                                     |
| ----------------- | ---------------------------------------------------------------------------------------- |
| GitHub Repository | https://github.com/github/spec-kit                                                       |
| Video Tutorial    | https://youtube.com/playlist?list=PL4cUxeGkcC9h9RbDpG8ZModUzwy45tLjb&si=OhwDsGlKuJ8sXQGK |


---

## 📄 API Specifications - OpenSpec

OpenSpec is our API specification and documentation standard for building consistent APIs.

### What It Covers
- API endpoint definitions
- Request/response schemas
- Authentication methods
- Error handling standards
- Versioning guidelines

### How to Use
1. Review existing API specs before building new endpoints
2. Follow naming conventions and patterns
3. Document all new endpoints in OpenSpec format
4. Validate specs before implementation

### 🔗 Resources & Links
| Resource               | Link                                        |
| ---------------------- | ------------------------------------------- |
| OpenSpec Documentation | https://github.com/Fission-AI/OpenSpec      |
| Video Tutorial         | https://www.youtube.com/watch?v=gHkdrO6IExM |


---

## 🐧 Linux Basics (Optional)

If you're new to Linux, this section will help you get comfortable with the command line before accessing the DGX Spark server.

### Why Learn Linux?
- Our server runs Ubuntu (a Linux distribution)
- Most development and AI/ML tools are designed for Linux
- Command line skills are essential for server management
- Many cloud platforms and containers use Linux

### Essential Commands

| Command | Description | Example |
|---------|-------------|---------|
| `ls` | List files and directories | `ls -la` |
| `cd` | Change directory | `cd /home/user` |
| `pwd` | Print current directory | `pwd` |
| `mkdir` | Create a directory | `mkdir my_project` |
| `rm` | Remove files/directories | `rm file.txt` |
| `cp` | Copy files | `cp file.txt backup.txt` |
| `mv` | Move or rename files | `mv old.txt new.txt` |
| `cat` | Display file contents | `cat script.py` |
| `nano` / `vim` | Text editors | `nano config.txt` |
| `chmod` | Change file permissions | `chmod +x script.sh` |
| `sudo` | Run as administrator | `sudo apt update` |
| `htop` | Monitor system processes | `htop` |
| `df` | Check disk space | `df -h` |
| `nvidia-smi` | Check GPU status | `nvidia-smi` |

### Getting Started
1. Practice with an online Linux terminal (no installation needed)
2. Watch the beginner tutorials linked below
3. Try basic commands on the DGX Spark server once you have access

### 🔗 Resources & Links
| Resource                    | Link                                        |
| --------------------------- | ------------------------------------------- |
| Linux Journey (Interactive) | https://linuxjourney.com                    |
| Linux Basics Video          | https://www.youtube.com/watch?v=16d2lHc0Pe8 |
| Command Line Crash Course   | https://www.youtube.com/watch?v=uwAqEzhyjtw |


---

## 🔀 Version Control - Git & GitHub

Git is our version control system for tracking code changes, and GitHub hosts our repositories where we collaborate on projects.

### 🔗 Resources & Links
| Resource            | Link                                             |
| ------------------- | ------------------------------------------------ |
| GitHub Organization | https://github.com/Wider-Community               |
| Git Basics Video    | https://youtu.be/e9lnsKot_SQ?si=Nw-LQJPh16GxtIJZ |


---

## 🤖 AI Coding Assistants

We use AI-powered coding assistants to boost productivity and code quality.

### Claude Code

Claude Code is Anthropic's official CLI tool for AI-assisted coding directly in your terminal.

#### Key Features
- Agentic coding in your terminal
- Code generation, debugging, and refactoring
- Multi-file editing and project understanding
- Works with any codebase

#### Getting Started
1. Install via npm: `npm install -g @anthropic-ai/claude-code`
2. Authenticate with your API key
3. Run `claude` in your project directory

### Gemini CLI

Gemini CLI is Google's command-line tool for AI-assisted development.

#### Key Features
- Code generation and explanation
- Multi-modal support (text, images, code)
- Integration with Google Cloud services

#### Getting Started
1. Install from https://github.com/google-gemini/gemini-cli
2. Authenticate with your Google account
3. Run `gemini` in your terminal

### 🔗 Resources & Links
| Resource           | Link                                        |
| ------------------ | ------------------------------------------- |
| Claude Code GitHub | https://github.com/anthropics/claude-code   |
| Gemini CLI GitHub  | https://github.com/google-gemini/gemini-cli |


---

## 🐛 Debugging

Debugging is an essential skill for identifying and fixing issues in your code.

### 🔗 Resources & Links
| Resource        | Link                                        |
| --------------- | ------------------------------------------- |
| Video Tutorial  | https://www.youtube.com/watch?v=3HiLLByBWkg |


---

## 📊 Project Management - GitHub Projects

We use GitHub Projects for task tracking and sprint management.

### Understanding the Board
| Column | Description |
|--------|-------------|
| 📋 Backlog | Tasks waiting to be prioritized |
| 📌 To Do | Tasks ready for the current sprint |
| 🔄 In Progress | Tasks being actively worked on |
| 👀 In Review | Tasks awaiting code review |
| ✅ Done | Completed tasks |

### Working with Issues
1. **Pick a task** from "To Do" column
2. **Assign yourself** to the issue
3. **Move to "In Progress"** when starting
4. **Create a branch** linked to the issue
5. **Submit PR** when ready for review
6. **Move to "In Review"** and request reviewers
7. **Move to "Done"** after merge

### Issue Labels
- `priority: high` - Urgent tasks
- `priority: medium` - Normal priority
- `priority: low` - When time permits
- `type: feature` - New functionality
- `type: bug` - Bug fixes
- `type: docs` - Documentation
- `good first issue` - Great for newcomers!

### 🔗 Resources & Links
| Resource              | Link                |
| --------------------- | ------------------- |
| Team Project Board    | `[Add project URL]` |
| GitHub Projects Video | `[Add video link]`  |
| Issue Templates       | `[Add link]`        |
| Sprint Planning Guide | `[Add attachment]`  |


---

## 🔢 Mathematics for AI

Understanding probability and statistics is fundamental for working with AI and machine learning models.

### Why It Matters
- Statistical foundations for understanding ML algorithms
- Probability theory for decision-making under uncertainty
- Data analysis and interpretation skills
- Essential for understanding model performance metrics

### 🔗 Resources & Links
| Resource                              | Link                                         |
| ------------------------------------- | -------------------------------------------- |
| Seeing Theory (Visual Probability)    | https://github.com/seeingtheory/Seeing-Theory |
| Statistics & Probability Course       | https://subasish.github.io/pages/course1/    |


---

> **Last Updated:** 28-12-2025
>
> **Questions?** Don't hesitate to reach out - we're here to help! 🚀
