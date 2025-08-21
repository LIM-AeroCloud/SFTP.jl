#!/usr/bin/env python3
"""
Issue Lister for SFTP.jl Repository

This script helps find and list all issues and pull requests in the repository,
including both open and closed items.

Usage:
    python3 scripts/list_issues.py
    
Environment Variables:
    GITHUB_TOKEN: Optional GitHub token for authentication (recommended for higher rate limits)
"""

import os
import requests
import json
from datetime import datetime
from typing import List, Dict, Optional

REPO_OWNER = "LIM-AeroCloud"
REPO_NAME = "SFTP.jl"

class IssueInfo:
    def __init__(self, number: int, title: str, state: str, item_type: str, 
                 author: str, created_at: str, closed_at: Optional[str], 
                 url: str, labels: List[str]):
        self.number = number
        self.title = title
        self.state = state
        self.type = item_type
        self.author = author
        self.created_at = created_at
        self.closed_at = closed_at
        self.url = url
        self.labels = labels

def get_github_token() -> str:
    """Get GitHub token from environment or return empty string for public access"""
    return os.environ.get("GITHUB_TOKEN", "")

def make_github_request(endpoint: str) -> Optional[List[Dict]]:
    """Make a request to GitHub API with optional authentication"""
    token = get_github_token()
    headers = {"User-Agent": "SFTP.jl-issue-lister"}
    
    if token:
        headers["Authorization"] = f"Bearer {token}"
    
    url = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/{endpoint}"
    
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        print(f"Warning: Failed to fetch {endpoint}: {e}")
        return None

def get_all_issues_and_prs() -> List[IssueInfo]:
    """Fetch all issues and pull requests (GitHub treats PRs as issues)"""
    all_items = []
    
    # Fetch both open and closed issues/PRs
    for state in ["open", "closed"]:
        page = 1
        while True:
            endpoint = f"issues?state={state}&page={page}&per_page=100"
            data = make_github_request(endpoint)
            
            if not data:
                break
            
            for item in data:
                # Determine if it's a PR or pure issue
                item_type = "pull_request" if "pull_request" in item else "issue"
                
                # Extract labels
                labels = [label["name"] for label in item.get("labels", [])]
                
                issue_info = IssueInfo(
                    number=item["number"],
                    title=item["title"],
                    state=item["state"],
                    item_type=item_type,
                    author=item["user"]["login"],
                    created_at=item["created_at"],
                    closed_at=item.get("closed_at"),
                    url=item["html_url"],
                    labels=labels
                )
                
                all_items.append(issue_info)
            
            # Check if there are more pages
            if len(data) < 100:
                break
            page += 1
    
    return sorted(all_items, key=lambda x: x.number)

def format_date(date_str: Optional[str]) -> str:
    """Format ISO date string to readable format"""
    if not date_str:
        return "N/A"
    # Simple date formatting - just take the date part
    return date_str.split("T")[0]

def print_summary(items: List[IssueInfo]):
    """Print a summary of all issues and PRs"""
    
    issues = [x for x in items if x.type == "issue"]
    prs = [x for x in items if x.type == "pull_request"]
    
    open_issues = [x for x in items if x.type == "issue" and x.state == "open"]
    closed_issues = [x for x in items if x.type == "issue" and x.state == "closed"]
    open_prs = [x for x in items if x.type == "pull_request" and x.state == "open"]
    closed_prs = [x for x in items if x.type == "pull_request" and x.state == "closed"]
    
    print("=" * 80)
    print("SFTP.jl Repository Issues and Pull Requests Summary")
    print("=" * 80)
    print()
    
    print("📊 SUMMARY STATISTICS")
    print(f"├─ Total Issues: {len(issues)} ({len(open_issues)} open, {len(closed_issues)} closed)")
    print(f"├─ Total Pull Requests: {len(prs)} ({len(open_prs)} open, {len(closed_prs)} closed)")
    print(f"└─ Total Items: {len(items)}")
    print()
    
    if issues:
        print(f"🐛 ISSUES ({len(issues)})")
        print("─" * 40)
        for issue in issues:
            status_icon = "🟢" if issue.state == "open" else "🔴"
            labels_str = f" [{', '.join(issue.labels)}]" if issue.labels else ""
            print(f"{status_icon} #{issue.number}: {issue.title}{labels_str}")
            print(f"   Author: {issue.author} | Created: {format_date(issue.created_at)} | {issue.url}")
            if issue.state == "closed":
                print(f"   Closed: {format_date(issue.closed_at)}")
            print()
    else:
        print("🐛 ISSUES: None found")
        print()
    
    if prs:
        print(f"🔧 PULL REQUESTS ({len(prs)})")
        print("─" * 40)
        for pr in prs:
            status_icon = "🟢" if pr.state == "open" else "🔴"
            labels_str = f" [{', '.join(pr.labels)}]" if pr.labels else ""
            print(f"{status_icon} #{pr.number}: {pr.title}{labels_str}")
            print(f"   Author: {pr.author} | Created: {format_date(pr.created_at)} | {pr.url}")
            if pr.state == "closed":
                print(f"   Closed: {format_date(pr.closed_at)}")
            print()

def main():
    """Main function to run the issue lister"""
    print(f"Fetching all issues and pull requests for {REPO_OWNER}/{REPO_NAME}...")
    print()
    
    items = get_all_issues_and_prs()
    
    if not items:
        print("No issues or pull requests found.")
        return
    
    print_summary(items)
    
    # Also check for issues mentioned in CHANGELOG
    print("🔗 ISSUES REFERENCED IN CHANGELOG")
    print("─" * 40)
    changelog_issues = [8, 9, 10, 13, 14, 18]
    for issue_num in changelog_issues:
        item = next((x for x in items if x.number == issue_num), None)
        if item:
            status_icon = "🟢" if item.state == "open" else "🔴"
            print(f"{status_icon} #{item.number}: {item.title} ({item.type})")
        else:
            print(f"❓ #{issue_num}: Referenced in CHANGELOG but not found")

if __name__ == "__main__":
    main()