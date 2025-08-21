# Error handling

__SFTP.jl__ handles multiple errors related to server access and file structure on the remote
system. Error codes are defined by the [`ErrorCode`](@ref SFTP.ErrorCode) enum and used as
error code in `Base.IOError`.

```@docs
SFTP.ErrorCode
```
