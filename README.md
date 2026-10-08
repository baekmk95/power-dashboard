# ⚡ POWER Dashboard

A lightweight terminal dashboard for monitoring **OpenAI Codex** and **Claude Code** usage side by side.

```text
+-------------------------------------------+    +-------------------------------------------+
              CODEX POWER                                 CLAUDE POWER
+-------------------------------------------+    +-------------------------------------------+

  ███████████████░░░░░  78.0% LEFT               █████████████░░░░░░░  63.5% LEFT
  3069 / 3950 CR remaining                        $95.19 / $150.00 remaining

  TODAY              123 CR                       TODAY               $4.23
  LAST 1H             17 CR                       LAST 1H              $0.82
  BURN RATE         22.1 CR/h                     BURN RATE            $0.71/h
  EST. RANGE         139 hours                    EST. RANGE           134 hours

  USAGE TREND - RECENT 4H                         USAGE TREND - RECENT 4H
  ▁▂▃▄▅▆▇█                                        ▁▂▃▄▅▆▇█

  STATUS    HIGH ENERGY                           STATUS    CRUISING
```

Both gauges use the same convention:

> **Percentage = remaining capacity**

## Features

- Codex and Claude usage in one terminal
- Side-by-side dashboard
- Remaining capacity gauge
- Today's usage
- Last-hour usage
- Burn rate
- Estimated hours remaining
- Recent 4-hour usage trend
- Automatic refresh every 5 minutes
- Manual refresh with `r`
- Responsive stacked layout on narrow terminals
- Existing Codex history reuse
- Local Claude history
- No external Python packages

## Quick install

```bash
curl -fsSL https://raw.githubusercontent.com/baekmk95/power-dashboard/master/install.sh | bash
```

Then run:

```bash
power
```

## Inspect before installing

```bash
curl -fsSL https://raw.githubusercontent.com/baekmk95/power-dashboard/master/install.sh
```

Or clone manually:

```bash
git clone https://github.com/baekmk95/power-dashboard.git
cd power-dashboard
./install.sh
```

## Requirements

### Common

- Linux or WSL
- Python 3
- `curl`

### Codex

POWER uses:

```bash
codexbar --provider codex
```

`codexbar` must already be installed and authenticated.

If Codex telemetry cannot be read, the Codex panel displays:

```text
DATA UNAVAILABLE
```

while the Claude panel continues to work.

### Claude Code

Claude Code must already be authenticated.

POWER reads the local Claude Code OAuth credential from:

```text
~/.claude/.credentials.json
```

and queries Claude's usage endpoint.

The credential itself is never printed or stored by POWER.

The Claude panel is designed primarily for accounts exposing usage-credit information such as:

```text
Usage credits
$54.81 / $150.00
```

## Controls

| Key | Action |
| --- | --- |
| `r` | Refresh immediately |
| `q` | Quit |
| `Ctrl+C` | Quit |

Automatic refresh occurs every **5 minutes**.

History samples are stored every **10 minutes**.

## History

Codex:

```text
~/.local/share/codex-usage/history.csv
```

Claude:

```text
~/.local/share/power-dashboard/claude-history.csv
```

These files are used for:

- TODAY
- LAST 1H
- BURN RATE
- EST. RANGE
- USAGE TREND

After first installation, some statistics initially show `--` or `collecting data...` until enough history has accumulated.

## Diagnostic mode

Print a single snapshot without entering the interactive dashboard:

```bash
power --once
```

## Update

Re-run the installer:

```bash
curl -fsSL https://raw.githubusercontent.com/baekmk95/power-dashboard/master/install.sh | bash
```

## Uninstall

```bash
rm ~/.local/bin/power
```

Optional Claude history cleanup:

```bash
rm -rf ~/.local/share/power-dashboard
```

Codex history is intentionally kept separate and is not removed.

## Security

POWER does not upload or persist authentication tokens.

Claude credentials are read locally only when requesting usage data.

Never commit:

```text
~/.claude/.credentials.json
```

or any other credential/token file to Git.

## Notes

The Claude usage endpoint used by this project is not a documented public API and may change in future Claude Code releases.

This project is intended as a lightweight terminal dashboard rather than a billing or accounting system.

## License

MIT
