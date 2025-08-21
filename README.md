# Julia SFTP Client

A Julia SFTP Client for exploring the structure and contents of SFTP servers and
exchanging files.

## Overview

This package is based on [SFTPClient.jl](https://github.com/stensmo/SFTPClient.jl.git)
and builds on [Downloads.jl](https://github.com/JuliaLang/Downloads.jl.git) and
[LibCurl.jl](https://github.com/JuliaWeb/LibCURL.jl.git).

_SFTP.jl_ supports username/password as well as certificates for authentication.
It provides methods to exchange files with the SFTP server as well as investigate the
folder structure and files with methods based on 
[Julia's Filesystem functions](https://docs.julialang.org/en/v1/base/file/).
Details can be found in the [documentation](docs-dev-url).

| **Documentation**                                                                  | **Build Status**                                                            |
|:----------------------------------------------------------------------------------:|:---------------------------------------------------------------------------:|
| [![Stable][docs-stable-img]][docs-stable-url] [![Dev][docs-dev-img]][docs-dev-url] | [![Build Status][CI-img]][CI-url] [![Coverage][codecov-img]][codecov-url] |

## Showcase

```julia
using SFTP
# Set up client for connection to server
sftp = SFTP.Client("sftp://test.rebex.net/pub/example/", "demo", "password")
# Analyse contents of current path
files=readdir(sftp)
statStructs = statscan(sftp)
# Download contents
download.(sftp, files)
```

```julia
using SFTP
# You can also load file contents to a variable by passing a function to download as first argument
# Note: the function must an AbstractString as parameter for a temporary path of the downloaded file
# Note: the path will be deleted immediately after the contents are saved to the variable
fread(path::AbstractString)::Vector{String} = readlines(path)
array = download(fread, sftp, "data/matrix.csv")

# Certificate authentication works as well
sftp = SFTP.Client("sftp://mysitewhereIhaveACertificate.com", "myuser")
sftp = SFTP.Client("sftp://mysitewhereIhaveACertificate.com", "myuser", "cert.pub", "cert.pem") # Assumes cert.pub and cert.pem is in your current path
# The cert.pem is your certificate (private key), and the cert.pub can be obtained from the private key.
# ssh-keygen -y  -f ./cert.pem. Save the output into "cert.pub". 
```

## Development and Issues

This project uses a pull request-based development workflow. All issues and features are tracked through pull requests rather than standalone GitHub issues.

### Finding Issues and Pull Requests

To view all issues and pull requests (including closed ones), you can:

1. **Quick overview**: Run the bash script for a summary
   ```bash
   ./scripts/list_issues.sh
   ```

2. **Detailed listing**: Use the Python or Julia scripts
   ```bash
   python3 scripts/list_issues.py
   # or
   julia scripts/list_issues.jl
   ```

3. **Static reference**: Check [`ISSUES_SUMMARY.md`](ISSUES_SUMMARY.md) for a comprehensive list

4. **GitHub interface**: Visit the [Issues page](https://github.com/LIM-AeroCloud/SFTP.jl/issues?q=is%3Aissue+is%3Aclosed) or [Pull Requests page](https://github.com/LIM-AeroCloud/SFTP.jl/pulls?q=is%3Apr+is%3Aclosed)

### Issue References in Releases

Key issues addressed in each release are documented in the [CHANGELOG](CHANGELOG.md):
- **v0.1.1**: #8 (type piracy), #9 (dirname function), #10 (readdir path conversion)
- **v0.1.2**: #13 (pwd deprecation), #14 (stat fallback)
- **Unreleased**: #18 (link target paths)

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://LIM-AeroCloud.github.io/SFTP.jl/stable/

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://LIM-AeroCloud.github.io/SFTP.jl/dev/

[CI-img]: https://github.com/LIM-AeroCloud/SFTP.jl/actions/workflows/CI.yml/badge.svg?branch=dev
[CI-url]: https://github.com/LIM-AeroCloud/SFTP.jl/actions/workflows/CI.yml?query=branch%3Adev

[codecov-img]: https://codecov.io/gh/LIM-AeroCloud/SFTP.jl/graph/badge.svg?token=kYZK3bRvCZ
[codecov-url]: https://codecov.io/gh/LIM-AeroCloud/SFTP.jl
