Function Read-FileLikeTail {
    param(
        [string]$path
    )

    Get-Content $path -Wait -Tail 1
}
