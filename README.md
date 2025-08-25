# catchr

---

### Deprecation

**catchr** is a deprecated module once used for **CPU fingerprinting** via `os.clock`. While it no longer works due to changes in Roblox's Lua runtime, the project has been open-sourced for educational purposes.

---

## Background

Previously, `os.clock` returned the **CPU uptime**—the time the Lua VM had actively spent executing code.  
This value varied slightly across devices, which allowed for a form of lightweight **client CPU fingerprinting**.
