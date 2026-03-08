# GPO: Drive Mapping (IT Admins)

## Overview
| Field | Value |
|---|---|
| GPO Name | IT-Drive-Map |
| Linked To | IT OU |
| Enforced | No |
| Purpose | Automatically map a shared network drive for IT staff at login |

---

## Configuration Path
```
User Configuration
  └── Preferences
        └── Windows Settings
              └── Drive Maps
```

---

## Drive Map Settings

| Field | Value |
|---|---|
| Action | Create |
| Location (UNC Path) | `\\DC01\IT-Share` |
| Drive Letter | Z: |
| Label | IT Share |
| Reconnect | Yes |
| Hide/Show drives | Show this drive |

---

## Item-Level Targeting
This GPO uses **Item-Level Targeting** to limit the drive map to members of the IT-Admins security group only.

| Setting | Value |
|---|---|
| Targeting Type | Security Group |
| Group | ASHLAB\IT-Admins |
| Effect | Drive only maps for IT-Admins members, even if others are in the IT OU |

---

## Shared Folder Configuration on DC01

The shared folder was created on DC01 at:
```
C:\Shares\IT-Share
```

Shared as:
```
\\DC01\IT-Share
```

### NTFS Permissions
| Principal | Permission |
|---|---|
| IT-Admins | Read & Write |
| Administrators | Full Control |

### Share Permissions
| Principal | Permission |
|---|---|
| IT-Admins | Change |
| Administrators | Full Control |

---

## Testing
Log into WS01 as an IT-Admins member (e.g. `ASHLAB\k.brown`) and verify:
1. Open **File Explorer** → Z: drive should appear under "This PC"
2. Verify you can create and delete files in Z:

To force a GPO refresh and re-map:
```powershell
gpupdate /force
```

To verify drive mappings from PowerShell:
```powershell
Get-PSDrive -PSProvider FileSystem
```

---

## Troubleshooting
| Issue | Fix |
|---|---|
| Z: drive not appearing | Run `gpupdate /force` and re-log in |
| Access denied on Z: | Verify user is in IT-Admins group in ADUC |
| UNC path unreachable | Confirm DC01 is running and DNS resolves `DC01` correctly |
| Drive maps to wrong letter | Check for drive letter conflict in GPO and re-map |

---

## Notes
- Drive Preferences (under User Configuration → Preferences) are different from Drive Maps in older GPO versions — Preferences are more flexible and support item-level targeting
- The Z: drive is only visible to IT-Admins, not to HR or Sales users
- UNC paths require the sharing service to be running on DC01
