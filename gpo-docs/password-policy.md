# GPO: Password Policy

## Overview
| Field | Value |
|---|---|
| GPO Name | Default Domain Policy |
| Linked To | ashlab.local (domain-wide) |
| Enforced | Yes |
| Purpose | Enforce secure password standards across all domain accounts |

---

## Configuration Path
```
Computer Configuration
  └── Policies
        └── Windows Settings
              └── Security Settings
                    └── Account Policies
                          └── Password Policy
```

---

## Settings Applied

| Policy Setting | Configured Value | Default Value | Reason |
|---|---|---|---|
| Minimum password length | 10 characters | 7 | Reduces brute force risk |
| Password must meet complexity requirements | Enabled | Disabled | Requires mix of uppercase, lowercase, numbers, symbols |
| Maximum password age | 90 days | 42 days | Forces regular rotation |
| Minimum password age | 1 day | 0 | Prevents immediate re-use |
| Enforce password history | 10 passwords | 24 | Prevents cycling back to old passwords |
| Store passwords using reversible encryption | Disabled | Disabled | Security best practice — never enable |

---

## What Password Complexity Requires
When complexity is enabled, passwords must contain characters from **3 of these 4** categories:
- Uppercase letters (A–Z)
- Lowercase letters (a–z)
- Numbers (0–9)
- Special characters (!@#$%^&*)

---

## Account Lockout Policy
```
Computer Configuration
  └── Policies
        └── Windows Settings
              └── Security Settings
                    └── Account Policies
                          └── Account Lockout Policy
```

| Policy Setting | Configured Value |
|---|---|
| Account lockout threshold | 5 invalid attempts |
| Account lockout duration | 30 minutes |
| Reset account lockout counter after | 30 minutes |

---

## Testing
To verify the policy is applied, run on any domain-joined machine:
```powershell
net accounts /domain
```
Expected output will show the configured password length, age, and history settings.

---

## Notes
- This GPO is linked at the domain root so it applies to **all users and computers** in ashlab.local
- Password policy for domain accounts can only be set at the domain level — OU-level password policies require Fine-Grained Password Policies (PSOs)
