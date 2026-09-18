<div align="center">

  <h1>🛡️ AFK_AntiSpamTrigger</h1>
  <p><strong>High-Performance Layer-7 Network Event Rate-Limiter & Anti-Flood Solution for FiveM</strong></p>

  [![Website](https://img.shields.io/badge/Official_Website-mamadrezaafk.top-blue?style=for-the-badge&logo=googlechrome&logoColor=white)](https://mamadrezaafk.top)
  [![Discord](https://img.shields.io/badge/Discord-Join_Community-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/GY5mSJFg77)
  [![FXServer](https://img.shields.io/badge/FXServer-Artifacts_5839+-orange.svg?style=for-the-badge&logo=fivem&logoColor=white)](https://fivem.net/)
  [![Lua](https://img.shields.io/badge/Lua-5.4-000080.svg?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org/)
  [![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)

  <p align="center">
    An ultra-lightweight (<strong>0.00ms resmon</strong>), standalone server-side security engine engineered to detect, throttle, and eliminate malicious <strong>Network Event Flooding</strong> and server-side thread lockups in real time.
  </p>

</div>

---

## ⚡ Overview

In multiplayer game environments, malicious actors often exploit client-side execution privileges to flood unvalidated network events. This results in severe tickrate drops, database transaction bottlenecks, state desynchronization, and server crashes.

**AFK_AntiSpamTrigger** operates directly on **Layer 7 (Application Layer)**. It provides real-time per-player bucket rate-limiting with near-zero resource consumption and comprehensive Discord webhook telemetry.

---

## ✨ Features

- **🚀 Maximum Performance (0.00ms):** Pure Lua 5.4 implementation with optimized hash lookups and zero garbage collection overhead.
- **🎯 Dual-Layer Throttling:**
  - **Global Threshold:** Limits aggregate network triggers dispatched per second by a single client.
  - **Single Event Cap:** Caps single event execution rates to stop targeted loop spamming.
  - **Strict Event Overrides:** Enforces custom limits for sensitive triggers (Banking, Inventory, Admin events).
- **🛡️ Multi-Level Enforcement:**
  - `log`: Passive telemetry monitoring directly dispatched to Discord.
  - `kick`: Automated, zero-tolerance kick execution upon exceeding the violation threshold.
- **📊 Rich Discord Embed Alerts:** Detailed logs containing Player Name, Server ID, Ping, Steam Hex, License, Discord ID, Trigger Name, and Breach Frequency.
- **🔑 Dynamic Admin Controls & ACL:**
  - Static configuration whitelist (Case-Insensitive Steam Hex, License, etc.).
  - In-game runtime commands protected by ACE permissions (`/afk_whitelist`, `/afk_unwhitelist`, `/afk_toggle`).
- **🌐 100% Framework Agnostic:** Fully compatible with **ESX**, **QBCore**, **Qbox**, **vRP**, and **Standalone** servers.

---

## 🏗️ Project Structure
```text
AFK_AntiSpamTrigger/
├── fxmanifest.lua        # FXv2 Resource Manifest (Lua 5.4)
├── config.lua            # Production Throttle Parameters & Policies
└── server.lua            # Core Inspection Pipeline & Webhook Dispatcher
