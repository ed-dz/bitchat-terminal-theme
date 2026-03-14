# ============================================================
#  bitchat PowerShell Profile
#  IRC-vibes terminal theme inspired by bitchat
#  Compatible with PowerShell 5 and PowerShell 7
# ============================================================

# ── Colour helpers ──────────────────────────────────────────
$ESC   = [char]27
function ansi($code) { "${ESC}[${code}m" }

$GREEN      = ansi "38;2;57;255;20"
$BRIGHTGREEN= ansi "38;2;127;255;0"
$CYAN       = ansi "38;2;0;255;204"
$YELLOW     = ansi "38;2;255;215;0"
$DIM        = ansi "38;2;100;140;100"
$RESET      = ansi "0"
$BOLD       = ansi "1"
$ITALIC     = ansi "3"

Clear-Host

# ── Fix directory colours (PS7+ only) ───────────────────────
if ($PSVersionTable.PSVersion.Major -ge 7) {
    $PSStyle.FileInfo.Directory    = "`e[38;2;0;255;204m"
    $PSStyle.FileInfo.SymbolicLink = "`e[38;2;127;255;0m"
    $PSStyle.FileInfo.Executable   = "`e[38;2;57;255;20m"
    $PSStyle.FileInfo.Extension.Clear()
}

function ll  { Get-ChildItem -Force @args | Format-Table Mode, LastWriteTime, Length, Name -AutoSize }
function la  { Get-ChildItem -Force @args }

function Get-GitBranch {
    try {
        $branch = git rev-parse --abbrev-ref HEAD 2>$null
        if ($branch) { return " ${DIM}[${BRIGHTGREEN}${branch}${DIM}]${RESET}" }
    } catch {}
    return ""
}

function prompt {
    $lastOk   = $?
    $exitCode = $LASTEXITCODE
    $ts       = Get-Date -Format "HH:mm:ss"
    $nick     = "@$env:USERNAME"
    $path     = $ExecutionContext.SessionState.Path.CurrentLocation
    $shortPath = ($path.ToString() -replace [regex]::Escape($HOME), "~")
    $git      = Get-GitBranch
    $status   = if ($lastOk) { "${GREEN}v${RESET}" } else { "${ESC}[38;2;255;68;68mx (${exitCode})${RESET}" }
    Write-Host "${DIM}[${ts}]${RESET} ${YELLOW}${shortPath}${RESET}${git}  ${status}"
    return "${GREEN}${BOLD}<${nick}>${RESET} "
}

Set-Alias -Name grep  -Value Select-String
Set-Alias -Name which -Value Get-Command
function touch { New-Item -ItemType File -Path $args -Force | Out-Null }
function ..    { Set-Location .. }
function ...   { Set-Location ..\.. }

if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -Colors @{
        Command          = "`e[38;2;57;255;20m"
        Parameter        = "`e[38;2;0;255;204m"
        String           = "`e[38;2;255;215;0m"
        Number           = "`e[38;2;127;255;0m"
        Variable         = "`e[38;2;0;191;255m"
        Operator         = "`e[38;2;100;140;100m"
        Type             = "`e[38;2;218;112;214m"
        Comment          = "`e[38;2;60;80;60m"
        InlinePrediction = "`e[38;2;60;100;60m"
        Keyword          = "`e[38;2;57;255;20;1m"
        Error            = "`e[38;2;255;68;68m"
    }
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle InlineView
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
}