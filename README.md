<div align="center">

  <h1>🛡️ AFK_AntiSpamTrigger</h1>
  <p><strong>High-Performance Network Event Rate-Limiting & Anti-Flood Solution for FiveM</strong></p>

  [![FXServer](https://img.shields.io/badge/FXServer-Artifacts_5839+-orange.svg?style=for-the-badge&logo=fivem&logoColor=white)](https://fivem.net/)
  [![Lua](https://img.shields.io/badge/Lua-5.4-blue.svg?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org/)
  [![Platform](https://img.shields.io/badge/VMP.ir-Verified_Resource-purple.svg?style=for-the-badge)](https://vmp.ir)
  [![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
  [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge)](https://github.com/)

  <p align="center">
    A lightweight (<strong>0.00ms resmon</strong>), standalone server-side security layer engineered to detect, throttle, and eliminate malicious <strong>Network Event Flooding</strong>, unauthorized event execution, and Layer 7 resource-exhaustion exploits.
  </p>

</div>

---

## ⚡ Overview

In multiplayer game servers, malicious actors exploit unvalidated or rapid client-to-server network triggers to exhaust server tickrates, desynchronize statebags, lag databases, or crash resource threads. 

**AFK_AntiSpamTrigger** acts as an inline Layer 7 packet throttle. It monitors incoming event queues per player, maintains low-overhead sliding window buckets, and takes decisive action—whether silent surveillance logging or instant zero-tolerance kick punishments.

---

## ✨ Key Features

- **🚀 Near-Zero Overhead (0.00ms idle/active):** Built completely in pure Lua 5.4 with optimized runtime hash tables, minimal memory footprint, and instant memory deallocation on player drop.
- **🎯 Dual-Layer Throttling Engine:**
  - **Global Packet Budget:** Limits the sum total of all triggers a client can broadcast per second.
  - **Single Event Threshold:** Prevents targeted event spamming (e.g., spamming economy/inventory endpoints).
  - **Strict Event Overrides:** Enforces custom limits for high-risk critical triggers (e.g., banking transactions, spawn triggers).
- **🛡️ Multi-Level Punishment Modes:**
  - `log`: Passive telemetry monitoring directly to your security webhook.
  - `kick`: Automated, configurable kick execution upon exceeding the violation threshold.
- **📊 Rich Discord Webhooks:** Detailed embed diagnostics containing Server ID, Ping, In-Game Name, Identifiers (Steam, License, Discord), Trigger Name, and Breach Frequency.
- **🔑 Dynamic Whitelisting & ACL Control:**
  - Static configuration whitelist for Steam Hex, License, or Custom IDs (Case-Insensitive).
  - Runtime runtime admin commands with ACE permission safeguards (`/afk_whitelist`, `/afk_unwhitelist`, `/afk_toggle`).
- **🌐 100% Framework Agnostic:** Seamlessly integrates with **ESX**, **QBCore**, **Qbox**, **vRP**, or completely custom **Standalone** codebases.

---

## 🏗️ Architecture & Project Structure
```text
AFK_AntiSpamTrigger/
├── fxmanifest.lua        # FXv2 Resource Manifest (Lua 5.4 runtime)
├── config.lua            # Production configuration & rule tables
└── server.lua            # Security throttle pipeline & Webhook dispatcher
