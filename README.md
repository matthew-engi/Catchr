# 🧠 catchr – CPU Fingerprinting Module

---

### 🛠️ Open Source

**catchr** is a deprecated module once used for **CPU fingerprinting** via `os.clock`. While it no longer works due to changes in Roblox's Lua runtime, the project has been open-sourced for educational purposes and historical interest.

---

## 📚 Background

Previously, `os.clock` returned the **CPU uptime**—the time the Lua VM had actively spent executing code.  
This value varied slightly across devices, which allowed for a form of lightweight **client CPU fingerprinting**.

---

## 💡 Why Open Source It?

Although the technique is no longer viable, **catchr** is public because:

- It can inspire future detection or analysis methods.  
- It contributes to my public portfolio, demonstrating skill in modular design.  
- It serves as a clean, well-documented example of maintainable code.
