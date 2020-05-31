"""Generate a random password."""
import argparse
import json
import math
import os
import random
import string

DIGITS = string.digits
LOWERCASE = string.ascii_lowercase
UPPERCASE = string.ascii_uppercase
SYMBOLS = "!@#$%^&*()-_=+[]{};:,.<>?"
AMBIGUOUS = "Il1O0o"
HISTORY_FILE = "password_history.json"

def build_pool(use_digits=True, use_lower=True, use_upper=True, use_symbols=True, no_ambiguous=False):
    chars = ""
    if use_digits:
        chars += DIGITS
    if use_lower:
        chars += LOWERCASE
    if use_upper:
        chars += UPPERCASE
    if use_symbols:
        chars += SYMBOLS
    if no_ambiguous:
        chars = "".join(c for c in chars if c not in AMBIGUOUS)
    if len(chars) == 0:
        raise SystemExit("Error: at least one character class must be enabled")
    return chars

def entropy(length, pool_size):
    if pool_size <= 1:
        return 0
    return length * math.log2(pool_size)

def strength_label(bits):
    if bits < 40:
        return "WEAK"
    elif bits < 60:
        return "FAIR"
    else:
        return "STRONG"

def generate_password(length, pool):
    return "".join(random.choice(pool) for _ in range(length))

def load_history():
    if os.path.exists(HISTORY_FILE):
        try:
            with open(HISTORY_FILE) as f:
                return json.load(f)
        except json.JSONDecodeError:
            return []
    return []

def save_to_history(password, length, bits, label):
    history = load_history()
    history.append({"password": password, "length": length, "entropy": round(bits, 1), "strength": label})
    with open(HISTORY_FILE, "w") as f:
        json.dump(history, f, indent=2)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    args = parser.parse_args()
    if args.length < 4:
        raise SystemExit("Error: length must be at least 4")
    pool = build_pool()
    pw = generate_password(args.length, pool)
    bits = entropy(args.length, len(pool))
    label = strength_label(bits)
    if args.save:
        save_to_history(pw, args.length, bits, label)
    print(f"{pw}  [{label}]")
