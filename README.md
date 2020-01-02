# 02 · Password Generator

A command-line password generator that uses **cryptographically secure** randomness.

## What it does

- Generates strong random passwords of any length
- Generates several at once (`-n`)
- Controls which character classes are used (digits, lowercase, uppercase, symbols)
- Option to exclude **ambiguous characters** (`1/l`, `0/O`) — handy when you'll be typing the password by hand

## How to run

```bash
python password_generator.py              # one 16-character password
python password_generator.py -l 24 -n 5   # five 24-character passwords
python password_generator.py --no-symbols --no-ambiguous
```

Example output:

```
$ python password_generator.py -l 20 -n 3
r#kH2vT8&mQ4xZ!wN6pD
P9b$cF3dR7gH1jK5lM2
wX4nY8qZ2vB6cN1mK3p
```

## What this project teaches

- **`argparse`** — building real, proper command-line tools (flags, defaults, help text)
- **`secrets` vs `random`** — why crypto-grade randomness is essential for anything security-related
- Designing a tool with **sensible defaults** and **validation** (minimum length, at least one class enabled)
- String & character-class handling

## Details

- Pure **standard library** — no dependencies
- Python 3.6+
