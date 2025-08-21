#!/bin/bash
#
# Simple issue lister using curl and basic shell tools
# Lists all issues and pull requests from the SFTP.jl repository
#

REPO_OWNER="LIM-AeroCloud"
REPO_NAME="SFTP.jl"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"

echo "================================================================================"
echo "SFTP.jl Repository Issues and Pull Requests Summary"
echo "================================================================================"
echo

# Function to make GitHub API requests
make_request() {
    local endpoint="$1"
    local url="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/${endpoint}"
    
    if [ -n "$GITHUB_TOKEN" ]; then
        curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
             -H "User-Agent: SFTP.jl-issue-lister" \
             "$url"
    else
        curl -s -H "User-Agent: SFTP.jl-issue-lister" "$url"
    fi
}

# Get repository info
echo "📋 Repository: ${REPO_OWNER}/${REPO_NAME}"
echo

# Try to fetch issues and PRs
echo "🔍 Fetching issues and pull requests..."
echo

# Fetch open issues/PRs
open_data=$(make_request "issues?state=open&per_page=100")
closed_data=$(make_request "issues?state=closed&per_page=100")

# Check if we got valid JSON responses
if echo "$open_data" | grep -q '"message".*"API rate limit exceeded"'; then
    echo "⚠️  API rate limit exceeded. Please try again later or set GITHUB_TOKEN environment variable."
    echo
elif echo "$open_data" | grep -q '"message"'; then
    echo "⚠️  API error: $(echo "$open_data" | grep -o '"message"[^}]*' | cut -d'"' -f4)"
    echo
else
    # Count items
    open_count=$(echo "$open_data" | grep -o '"number":' | wc -l)
    closed_count=$(echo "$closed_data" | grep -o '"number":' | wc -l)
    total_count=$((open_count + closed_count))
    
    echo "📊 SUMMARY STATISTICS"
    echo "├─ Open items: $open_count"
    echo "├─ Closed items: $closed_count"  
    echo "└─ Total items: $total_count"
    echo
    
    if [ $total_count -eq 0 ]; then
        echo "No issues or pull requests found."
    else
        echo "💡 Use the Python or Julia scripts in scripts/ directory for detailed listings."
        echo "💡 Or visit: https://github.com/${REPO_OWNER}/${REPO_NAME}/issues?q=is%3Aissue+is%3Aclosed"
    fi
fi

echo
echo "🔗 ISSUES REFERENCED IN CHANGELOG"
echo "────────────────────────────────────────"
echo "The following items are mentioned in CHANGELOG.md:"
echo "• #8:  Bug/type piracy (v0.1.1)"
echo "• #9:  Add function dirname, update docs (v0.1.1)" 
echo "• #10: Convert path to String in readdir (v0.1.1)"
echo "• #13: Feat/pwd deprecate (v0.1.2)"
echo "• #14: Bug/stat (v0.1.2)"
echo "• #18: Fix absolute path of link targets in StatStruct (Unreleased)"
echo
echo "📖 For complete details, see ISSUES_SUMMARY.md"
echo "🛠️  For real-time data, use scripts/list_issues.py or scripts/list_issues.jl"