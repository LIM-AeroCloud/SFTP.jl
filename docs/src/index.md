# SFTP.jl

*An SFTP Client for Julia.*

_SFTP.jl_ is a pure Julia package for connecting to servers with the secure file
transfer protocol (SFTP), supporting authentication by username and password or
by certificates. Main purpose is the file exchange between the SFTP server and the
local system. Basic file system functions similar to Julia's Base functions and
to the typical Linux functionality exist to explore the SFTP server.

## SFTP Feature overview

- Connection to SFTP server by username/password or with certificate authentication
- File [`upload`](@ref)/[`download`](@ref) to/from server
- Inspect the server with file system functions like [`walkdir`](@ref), [`readdir`](@ref),
  [`stat`](@ref)/[`statscan`](@ref), [`filemode`](@ref), [`ispath`](@ref), [`isdir`](@ref),
  [`isfile`](@ref), [`islink`](@ref)
- Navigate and manipulate server content with functions like [`pwd`](@ref), [`cd`](@ref),
  [`mv`](@ref), [`rm`](@ref), [`mkdir`](@ref), [`mkpath`](@ref)
- Create script with the help of further filesystem functions like [`joinpath`](@ref),
  [`basename`](@ref), [`dirname`](@ref) or [`splitdir`](@ref)

## SFTP Installation

_SFTP.jl_ is an unregistered Julia package, but can be installed with the package manager:

```console
julia> ]

pkg> add https://github.com/LIM-AeroCloud/SFTP.jl.git
```

By default, the development version will be install. To use released stable version switch to
the `main` channel by installing _SFTP.jl_ with:

```console
pkg> add https://github.com/LIM-AeroCloud/SFTP.jl.git#main
```

The package is developed for MacOS and Linux, but can be used under Windows as well.
It is tested against the long-term support version (LTS) of Julia, the latest stable version,
and the nightly version. To run test on your system open the package manager and type `test`:

```console
pkg> test
```

## Contents

```@contents
Pages = [
    "index.md",
    "server.md",
    "filesystem.md",
    "troubleshooting.md",
    "release-notes.md",
    "register.md"
]
```
