# SFTP.jl Issues and Pull Requests Summary

This document provides a comprehensive list of all issues and pull requests in the SFTP.jl repository.

## Summary Statistics

- **Total Issues**: 0 (0 open, 0 closed)  
- **Total Pull Requests**: 18 (0 open, 18 closed)  
- **Total Items**: 18

**Note**: This repository uses GitHub's pull request system exclusively. All development and bug fixes are tracked through pull requests rather than standalone issues.

## Pull Requests (All Closed)

### #1: Bump codecov/codecov-action from 4 to 5
- **Author**: dependabot[bot]
- **Created**: 2025-01-22
- **Closed**: 2025-01-22  
- **Labels**: dependencies
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/1
- **Type**: Dependency update

### #2: Feat/filesystem
- **Author**: pb866
- **Created**: 2025-03-20
- **Closed**: 2025-03-20
- **Description**: Complete functions for the filesystem similar to Julia's filesystem functions
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/2
- **Type**: Feature

### #3: Feat/tests
- **Author**: pb866  
- **Created**: 2025-03-23
- **Closed**: 2025-04-13
- **Description**: Complete tests where possible without having to mock an sftp server
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/3
- **Type**: Testing

### #8: Bug/type piracy
- **Author**: pb866
- **Created**: 2025-05-19
- **Closed**: 2025-05-24
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/8
- **Type**: Bug fix
- **Referenced in**: CHANGELOG v0.1.1

### #9: Add function dirname, update docs
- **Author**: pb866
- **Created**: 2025-05-24
- **Closed**: 2025-05-24
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/9
- **Type**: Enhancement
- **Referenced in**: CHANGELOG v0.1.1

### #10: Convert path to String in readdir
- **Author**: pb866
- **Created**: 2025-05-24
- **Closed**: 2025-05-24
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/10
- **Type**: Bug fix
- **Referenced in**: CHANGELOG v0.1.1

### #13: Feat/pwd deprecate
- **Author**: pb866
- **Created**: 2025-05-30
- **Closed**: 2025-05-30
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/13
- **Type**: Deprecation
- **Referenced in**: CHANGELOG v0.1.2

### #14: Bug/stat
- **Author**: pb866
- **Created**: 2025-05-31
- **Closed**: 2025-05-31
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/14
- **Type**: Bug fix
- **Referenced in**: CHANGELOG v0.1.2

### #15: Rel/0.1.2
- **Author**: pb866
- **Created**: 2025-05-31
- **Closed**: 2025-05-31
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/15
- **Type**: Release

### #16: Rel/0.1.2
- **Author**: pb866
- **Created**: 2025-05-31
- **Closed**: 2025-05-31
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/16
- **Type**: Release

### #17: Rel/0.1.2
- **Author**: pb866
- **Created**: 2025-05-31
- **Closed**: 2025-05-31
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/17
- **Type**: Release

### #18: Fix absolute path of link targets in StatStruct
- **Author**: pb866
- **Created**: 2025-05-31
- **Closed**: 2025-05-31
- **URL**: https://github.com/LIM-AeroCloud/SFTP.jl/pull/18
- **Type**: Bug fix
- **Referenced in**: CHANGELOG (Unreleased)

## Issues Referenced in CHANGELOG

The following pull requests are specifically referenced in the CHANGELOG as addressing particular issues:

1. **#8**: Type piracy issues - deprecated methods to avoid conflicts
2. **#9**: Added dirname function for SFTP 
3. **#10**: Fixed path string conversion in readdir function
4. **#13**: Deprecated path checks in pwd function
5. **#14**: Added fallback solution for filemode determination
6. **#18**: Fixed absolute path display for link targets

## Development Workflow

This project follows a pull request-based development workflow where:

- All changes are made through pull requests
- Issues are typically addressed directly via pull requests rather than being tracked separately
- The CHANGELOG references specific pull requests that fix issues
- Releases are managed through dedicated release pull requests (#15, #16, #17)

## Tools for Browsing Issues

Two scripts are provided in the `scripts/` directory:
- `scripts/list_issues.py` - Python script for comprehensive issue listing
- `scripts/list_issues.jl` - Julia script for comprehensive issue listing

These scripts can provide real-time data when run with appropriate GitHub API access.