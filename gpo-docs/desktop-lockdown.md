# GPO: Desktop Lockdown

## Overview
| Field | Value |
|---|---|
| GPO Name | Desktop-Lockdown |
| Linked To | HR OU, Sales OU |
| Enforced | No |
| Purpose | Restrict end-user configuration for non-technical staff |

---

## Configuration Path
```
User Configuration
  └── Policies
        └── Administrative Templates
              ├── Control Panel
              │     └── Personalization
              └── System
```

---

## Settings Applied

### Control Panel → Personalization
| Policy Setting | Value | Reason |
|---|---|---|
| Prevent changing desktop background | Enabled | Maintains professional appearance, reduces support tickets |
| Prevent changing color and appearance | Enabled | Standardizes desktop environment |
| Prevent changing screen saver | Enabled | Ensures screen lock policy is not bypassed |

---

### System
| Policy Setting | Value | Reason |
|---|---|---|
| Prevent access to the command prompt | Enabled | Blocks cmd.exe to reduce unauthorized script execution |
| Prevent access to registry editing tools | Enabled | Blocks regedit to protect system configuration |

---

## Scope
This GPO is linked to two OUs:

| OU | Users Affected |
|---|---|
| HR | j.smith, p.patel |
| Sales | m.garcia, m.johnson |

IT staff are **excluded** from this GPO — it is not linked to the IT OU, so IT-Admins retain full desktop control.

---

## Testing
To verify the policy applied to a user, log in as a domain user in HR or Sales and confirm:
1. Right-clicking the desktop → **Personalize** is blocked or options are grayed out
2. Searching for `cmd` in Start shows Command Prompt is inaccessible

To check which GPOs are applied to a logged-in user, run:
```powershell
gpresult /r
```

To force an immediate GPO refresh:
```powershell
gpupdate /force
```

---

## Notes
- This is a **User Configuration** GPO — it follows the user, not the computer
- If an HR user logs into an IT workstation, this GPO still applies to them
- GPO processing order: Local → Site → Domain → OU (LSDOU). OU-linked GPOs apply last and win conflicts
