# System Vitals

How the machine is doing - CPU, memory and uptime - and what is hogging it when something is wrong.

A feature for [Mavis AI](https://www.mavis-ai.com) — a desktop voice assistant.

```
You: "how is my pc doing"
```

Mavis answers out loud:

```
"All healthy. CPU 32 percent, memory 68 percent used, up 1 day."
"Memory is tight - 94 percent used, with chrome the biggest. CPU 22 percent, up 3 days."
```

It reports the **exception, not the inventory** — the reply is spoken, so a list would be unusable.

## Install

From the Mavis Appstore — find **System Vitals** and click Install.

Or install it directly:

```python
from utils.feature_install import install_from_github
install_from_github("https://github.com/keefng8/system-vitals")
```

## What you can say

- *"how is my pc doing"*
- *"system status"*
- *"check system vitals"*
- *"is my computer struggling"*
- *"what is using my memory"*

These are not matched word for word. Mavis gives them to its language model as examples of intent, so close variations work too.

## How it works

Leads with whatever is actually notable. If memory or CPU is under pressure it names the biggest process; if nothing is wrong it says so and stops.

## Requirements

None. Windows PowerShell, which every Windows machine already has.

## Building your own

See [Building features for Mavis](https://github.com/keefng8/mavis-feature-docs) — a feature is just a GitHub repository with a `mavis.json`.

## License

MIT — see [LICENSE](LICENSE).
