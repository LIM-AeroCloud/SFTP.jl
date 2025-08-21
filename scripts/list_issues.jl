#!/usr/bin/env julia
"""
Issue Lister for SFTP.jl Repository

This script helps find and list all issues and pull requests in the repository,
including both open and closed items.
"""

using HTTP
using JSON3

const REPO_OWNER = "LIM-AeroCloud"
const REPO_NAME = "SFTP.jl"

struct IssueInfo
    number::Int
    title::String
    state::String
    type::String  # "issue" or "pull_request"
    author::String
    created_at::String
    closed_at::Union{String,Nothing}
    url::String
    labels::Vector{String}
end

function get_github_token()
    """Get GitHub token from environment or return empty string for public access"""
    return get(ENV, "GITHUB_TOKEN", "")
end

function make_github_request(endpoint::String)
    """Make a request to GitHub API with optional authentication"""
    token = get_github_token()
    headers = ["User-Agent" => "SFTP.jl-issue-lister"]
    
    if !isempty(token)
        push!(headers, "Authorization" => "Bearer $token")
    end
    
    url = "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/$endpoint"
    
    try
        response = HTTP.get(url, headers)
        return JSON3.read(response.body)
    catch e
        @warn "Failed to fetch $endpoint" exception=e
        return nothing
    end
end

function get_all_issues_and_prs()
    """Fetch all issues and pull requests (GitHub treats PRs as issues)"""
    all_items = IssueInfo[]
    
    # Fetch both open and closed issues/PRs
    for state in ["open", "closed"]
        page = 1
        while true
            endpoint = "issues?state=$state&page=$page&per_page=100"
            data = make_github_request(endpoint)
            
            if data === nothing || isempty(data)
                break
            end
            
            for item in data
                # Determine if it's a PR or pure issue
                item_type = haskey(item, :pull_request) ? "pull_request" : "issue"
                
                # Extract labels
                labels = String[]
                if haskey(item, :labels) && item.labels !== nothing
                    for label in item.labels
                        push!(labels, label.name)
                    end
                end
                
                issue_info = IssueInfo(
                    item.number,
                    item.title,
                    item.state,
                    item_type,
                    item.user.login,
                    item.created_at,
                    get(item, :closed_at, nothing),
                    item.html_url,
                    labels
                )
                
                push!(all_items, issue_info)
            end
            
            # Check if there are more pages
            if length(data) < 100
                break
            end
            page += 1
        end
    end
    
    return sort(all_items, by = x -> x.number)
end

function format_date(date_str::Union{String,Nothing})
    """Format ISO date string to readable format"""
    if date_str === nothing
        return "N/A"
    end
    # Simple date formatting - just take the date part
    return split(date_str, "T")[1]
end

function print_summary(items::Vector{IssueInfo})
    """Print a summary of all issues and PRs"""
    
    issues = filter(x -> x.type == "issue", items)
    prs = filter(x -> x.type == "pull_request", items)
    
    open_issues = filter(x -> x.type == "issue" && x.state == "open", items)
    closed_issues = filter(x -> x.type == "issue" && x.state == "closed", items)
    open_prs = filter(x -> x.type == "pull_request" && x.state == "open", items)
    closed_prs = filter(x -> x.type == "pull_request" && x.state == "closed", items)
    
    println("=" ^ 80)
    println("SFTP.jl Repository Issues and Pull Requests Summary")
    println("=" ^ 80)
    println()
    
    println("📊 SUMMARY STATISTICS")
    println("├─ Total Issues: $(length(issues)) ($(length(open_issues)) open, $(length(closed_issues)) closed)")
    println("├─ Total Pull Requests: $(length(prs)) ($(length(open_prs)) open, $(length(closed_prs)) closed)")
    println("└─ Total Items: $(length(items))")
    println()
    
    if !isempty(issues)
        println("🐛 ISSUES ($(length(issues)))")
        println("─" ^ 40)
        for issue in issues
            status_icon = issue.state == "open" ? "🟢" : "🔴"
            labels_str = isempty(issue.labels) ? "" : " [$(join(issue.labels, ", "))]"
            println("$status_icon #$(issue.number): $(issue.title)$labels_str")
            println("   Author: $(issue.author) | Created: $(format_date(issue.created_at)) | $(issue.url)")
            if issue.state == "closed"
                println("   Closed: $(format_date(issue.closed_at))")
            end
            println()
        end
    else
        println("🐛 ISSUES: None found")
        println()
    end
    
    if !isempty(prs)
        println("🔧 PULL REQUESTS ($(length(prs)))")
        println("─" ^ 40)
        for pr in prs
            status_icon = pr.state == "open" ? "🟢" : "🔴"
            labels_str = isempty(pr.labels) ? "" : " [$(join(pr.labels, ", "))]"
            println("$status_icon #$(pr.number): $(pr.title)$labels_str")
            println("   Author: $(pr.author) | Created: $(format_date(pr.created_at)) | $(pr.url)")
            if pr.state == "closed"
                println("   Closed: $(format_date(pr.closed_at))")
            end
            println()
        end
    end
end

function main()
    """Main function to run the issue lister"""
    println("Fetching all issues and pull requests for $REPO_OWNER/$REPO_NAME...")
    println()
    
    items = get_all_issues_and_prs()
    
    if isempty(items)
        println("No issues or pull requests found.")
        return
    end
    
    print_summary(items)
    
    # Also check for issues mentioned in CHANGELOG
    println("🔗 ISSUES REFERENCED IN CHANGELOG")
    println("─" ^ 40)
    changelog_issues = [8, 9, 10, 13, 14, 18]
    for issue_num in changelog_issues
        item = findfirst(x -> x.number == issue_num, items)
        if item !== nothing
            issue = items[item]
            status_icon = issue.state == "open" ? "🟢" : "🔴"
            println("$status_icon #$(issue.number): $(issue.title) ($(issue.type))")
        else
            println("❓ #$issue_num: Referenced in CHANGELOG but not found")
        end
    end
end

# Run the script if called directly
if abspath(PROGRAM_FILE) == @__FILE__
    main()
end