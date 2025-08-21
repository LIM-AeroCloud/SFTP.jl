module SFTP

# Error Codes for Error Handling of IO Errors
"""
# Enum `ErrorCode`

Error codes for SFTP connection and remote filesystem errors:

    EC_NOERROR = 0
    EC_ACCESS_DENIED = 1
    EC_NOT_A_FILE = 2
    EC_NOT_A_DIR = 3
    EC_NOT_A_PATH = 4
    EC_FILE_NOT_FOUND = 5
    EC_DIR_NOT_FOUND = 6
    EC_PATH_NOT_FOUND = 7
    EC_FILE_EXISTS = 8
    EC_DIR_EXISTS = 9
    EC_PATH_EXISTS = 10
    EC_NONEMPTY_DIR = 11
    EC_BROKEN_LINK = 12
    EC_INVALID_SCAN = 13
"""
ErrorCode

@enum ErrorCode begin
    EC_NOERROR = 0
    EC_ACCESS_DENIED = 1
    EC_NOT_A_FILE = 2
    EC_NOT_A_DIR = 3
    EC_NOT_A_PATH = 4
    EC_FILE_NOT_FOUND = 5
    EC_DIR_NOT_FOUND = 6
    EC_PATH_NOT_FOUND = 7
    EC_FILE_EXISTS = 8
    EC_DIR_EXISTS = 9
    EC_PATH_EXISTS = 10
    EC_NONEMPTY_DIR = 11
    EC_BROKEN_LINK = 12
    EC_INVALID_SCAN = 13
end

# Package imports
import Downloads
import LibCURL
import URIs
import Dates
import Logging
import Downloads: Downloader, Curl.Easy
import URIs: URI

# File includes
include("client.jl")
include("fileexchange.jl")
include("filestats.jl")
include("filesystem.jl")
include("deprecated.jl")

# Define API and export structs and functions
@static if VERSION ≥ v"1.11"
    eval(Meta.parse("public Client, StatStruct, download, stat, filemode, ispath, isdir, isfile, islink, pwd, cd, mv, rm, mkdir, mkpath, readdir, walkdir, joinpath, splitdir, dirname, basename"))
end

export upload, statscan, URI

end # module SFTP
