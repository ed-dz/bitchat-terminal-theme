# bitchat-terminal-theme

> *IRC vibes. Neon green. Pure black. No fluff.*

A Windows Terminal colour scheme and PowerShell profile inspired by **[bitchat](https://github.com/permissionlesstech/bitchat)** — the decentralised Bluetooth mesh chat app with the soul of a 90s IRC client.

---

## Inspiration

The first time I saw bitchat, it wasn't the tech that hooked me — it was the *aesthetic*.

Pure black background. Neon green monospace text. Timestamps on every line. System events in cyan (`* rick connected *`). A prompt that looks like `<@jack>`. No gradients, no rounded corners, no dark-mode greys. Just signal and noise, rendered in phosphor green on a screen that feels like it's running at 3am on a rooftop.

That's the energy this terminal profile tries to bring to your everyday Windows Terminal. Every time you open a shell, you get that same feeling — like you're jacked into something real.

---

## What's included

| File | Purpose |
|------|---------|
| `settings.json` | Windows Terminal colour scheme (`bitchat`) |
| `Microsoft.PowerShell_profile.ps1` | PowerShell prompt + IRC-style `/commands` |

---

## Colours

| Role | Hex | |
|------|-----|-|
| Primary / foreground | `#39FF14` | Neon green |
| System events | `#00FFCC` | Cyan |
| Paths | `#FFD700` | Gold |
| Bright accent | `#7FFF00` | Lime |
| Error | `#FF4444` | Red |
| Background | `#000000` | Pure black |

---

## Quick Install

### 1. Windows Terminal colour scheme

Press `Ctrl+,` in Windows Terminal → **Open JSON file** → merge the `"bitchat"` entry into your `"schemes"` array, then set:
```json
"profiles": {
  "defaults": {
    "colorScheme": "bitchat",
    "font": { "face": "JetBrains Mono", "size": 13 }
  }
}
```

### 2. PowerShell profile
```powershell
# Allow scripts
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

# Backup existing profile
if (Test-Path $PROFILE) { Copy-Item $PROFILE "$PROFILE.bak" }

# Download and apply
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ed-dz/bitchat-terminal-theme/main/Microsoft.PowerShell_profile.ps1" -OutFile $PROFILE
```

Restart Windows Terminal. You'll be greeted with:
```
[03:14:01] * get people around you to download bitchat...and chat with them here! *
[03:14:11] * herak connected *

  type /help for IRC-style commands

<@herak> _
```

### 3. Font (recommended)
```powershell
winget install JetBrains.JetBrainsMono
```

> If the font doesn't register: find the `.ttf` files, right-click → **Install for all users**.

---

## IRC Commands

Once the profile is loaded:

| Command | Action |
|---------|--------|
| `/help` | Show all commands |
| `/w` | See who's online |
| `/clear` | Clear the terminal |
| `/channels` | Show discovered channels |
| `/msg <nick>` | Open a DM |

---

## Credits

- **[bitchat](https://github.com/permissionlesstech/bitchat)** by [@jackjack](https://twitter.com/jack) — the app that started all this
- **[JetBrains Mono](https://www.jetbrains.com/lp/mono/)** — the font
- **[Cascadia Mono](https://github.com/microsoft/cascadia-code)** — fallback font, ships with Windows Terminal

---

*No accounts. No central servers. Just a shell that looks like it means business.*