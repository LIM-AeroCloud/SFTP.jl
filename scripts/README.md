# Issue Lister Scripts

This directory contains scripts to help find and list all issues and pull requests in the SFTP.jl repository.

## Scripts Available

### 1. `list_issues.sh` (Bash - Recommended)
A simple bash script that provides basic issue statistics and references.

**Requirements:**
- bash
- curl

**Usage:**
```bash
./scripts/list_issues.sh
```

### 2. `list_issues.py` (Python)
A Python script that lists all issues and pull requests with detailed information.

**Requirements:**
- Python 3.6+
- `requests` library (install with `pip install requests`)

**Usage:**
```bash
python3 scripts/list_issues.py
```

### 3. `list_issues.jl` (Julia)
A Julia script that provides the same functionality as the Python version.

**Requirements:**
- Julia 1.6+
- HTTP.jl and JSON3.jl packages

**Usage:**
```bash
julia scripts/list_issues.jl
```

## Features

- **`list_issues.sh`** provides:
  - Quick summary statistics
  - Basic API connectivity test
  - CHANGELOG cross-references
  - Links to detailed documentation

- **`list_issues.py`** and **`list_issues.jl`** provide:
  - Complete listing of all issues and pull requests (open and closed)
  - Summary statistics showing counts by type and status
  - Detailed information for each item including:
    - Issue/PR number and title
    - Author and creation date
    - Current state (open/closed) and close date if applicable
    - Labels assigned
    - Direct link to GitHub
  - CHANGELOG cross-reference showing issues mentioned in the CHANGELOG

## Authentication

For higher rate limits and access to private repositories, you can provide a GitHub token:

```bash
export GITHUB_TOKEN="your_github_token_here"
./scripts/list_issues.sh
# or
python3 scripts/list_issues.py
```

## Sample Output

### From `list_issues.sh`:
```
================================================================================
SFTP.jl Repository Issues and Pull Requests Summary
================================================================================

📋 Repository: LIM-AeroCloud/SFTP.jl

🔍 Fetching issues and pull requests...

📊 SUMMARY STATISTICS
├─ Open items: 0
├─ Closed items: 18
└─ Total items: 18

💡 Use the Python or Julia scripts in scripts/ directory for detailed listings.

🔗 ISSUES REFERENCED IN CHANGELOG
────────────────────────────────────────
• #8:  Bug/type piracy (v0.1.1)
• #9:  Add function dirname, update docs (v0.1.1)
• #10: Convert path to String in readdir (v0.1.1)
• #13: Feat/pwd deprecate (v0.1.2)
• #14: Bug/stat (v0.1.2)
• #18: Fix absolute path of link targets in StatStruct (Unreleased)
```

### From detailed scripts:
```
================================================================================
SFTP.jl Repository Issues and Pull Requests Summary
================================================================================

📊 SUMMARY STATISTICS
├─ Total Issues: 0 (0 open, 0 closed)
├─ Total Pull Requests: 18 (0 open, 18 closed)
└─ Total Items: 18

🐛 ISSUES: None found

🔧 PULL REQUESTS (18)
────────────────────────────────────────
🔴 #1: Bump codecov/codecov-action from 4 to 5 [dependencies]
   Author: dependabot[bot] | Created: 2025-01-22 | https://github.com/LIM-AeroCloud/SFTP.jl/pull/1
   Closed: 2025-01-22

...

🔗 ISSUES REFERENCED IN CHANGELOG
────────────────────────────────────────
🔴 #8: Bug/type piracy (pull_request)
🔴 #9: Add function dirname, update docs (pull_request)
🔴 #10: Convert path to String in readdir (pull_request)
🔴 #13: Feat/pwd deprecate (pull_request)
🔴 #14: Bug/stat (pull_request)
🔴 #18: Fix absolute path of link targets in StatStruct (pull_request)
```

## Notes

- In GitHub's data model, pull requests are treated as special types of issues
- This repository appears to have only pull requests, no standalone issues
- All referenced items in the CHANGELOG are actually pull requests that addressed specific issues