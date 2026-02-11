# Bash Learning Guide

## Recommended Book

**Pro Bash Programming: Scripting the GNU/Linux Shell** by Chris F.A. Johnson

*Why this book?*
- Focuses on real-world shell programming
- Teaches best practices (quoting, functions, debugging, etc.)
- Helps you avoid common pitfalls

*Optional second book for beginners:* **Learning the Bash Shell (O'Reilly)**

---

## 5 Projects to Become Decent at Bash

### 1) Directory Backup Script
Automatically back up a directory to a “backup” folder with a timestamp.

Skills:
- Positional arguments ($1, $2)
- Date formatting
- Quoting paths
- Conditionals and error handling

Example usage:
```
./backup.sh /path/to/dir
```

### 2) Interactive Menu Tool
Make a script that shows a menu like:
```
1) List files
2) Show disk usage
3) Show active users
4) Quit
```

Skills:
- `select` or `read` loops
- Case statements
- Functions

### 3) Log Rotator
Given a log directory, compress logs older than *n* days and rotate them.

Skills:
- Loops
- `find`
- `gzip`
- Working with timestamps and flags

### 4) Batch File Renamer
Prompt user for a pattern and rename all matching files:
```
Enter pattern to replace:
old → new
```

Skills:
- String manipulation
- Pattern matching (`*`, regex)
- Safety checks & interactive prompts

### 5) Mini Deployment Script
Script that:
1. Pulls latest code from Git
2. Builds it
3. Deploys to a directory
4. Logs the result

Skills:
- Calling external tools (`git`, `make`)
- Exit codes
- Logging & timestamps
- Functions + modular scripting

---

## Tips to Avoid Basic Bash Issues

- **Always quote variables:**
```bash
"$var"
```
- **Use strict mode:**
```bash
set -euo pipefail
```
This helps catch bugs early.

