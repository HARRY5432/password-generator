"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
from datetime import datetime

DIGITS = string.digits
LOWERCASE = string.ascii_lowercase
UPPERCASE = string.ascii_uppercase
SYMBOLS = "!@#$%^&*()-_=+[]{};:,.<>?"
AMBIGUOUS = "Il1O0o"
HISTORY_FILE = "password_history.json"

WORD_LIST = [
    "apple", "brave", "cloud", "delta", "eagle", "flame", "grape", "house",
    "ivory", "jolly", "kneel", "lemon", "mango", "noble", "ocean", "piano",
    "quest", "river", "storm", "tiger", "unity", "vivid", "whale", "xenon",
    "yacht", "zebra", "amber", "blaze", "coral", "drift"
]

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

def generate_passphrase(num_words=4, separator="-"):
    return separator.join(random.choice(WORD_LIST) for _ in range(num_words))

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
    history.append({
        "password": password,
        "length": length,
        "entropy": round(bits, 1),
        "strength": label,
        "timestamp": datetime.now().isoformat()
    })
    with open(HISTORY_FILE, "w") as f:
        json.dump(history, f, indent=2)

def export_csv(filename="passwords.csv"):
    history = load_history()
    with open(filename, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["password", "length", "entropy", "strength", "timestamp"])
        writer.writeheader()
        writer.writerows(history)
    print(f"exported {len(history)} entries to {filename}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    parser.add_argument("--export", action="store_true", help="export history to csv")
    parser.add_argument("--passphrase", action="store_true", help="generate passphrase instead")
    args = parser.parse_args()
    if args.export:
        export_csv()
    elif args.load:
        for entry in load_history():
            print(f"{entry['password']}  [{entry['strength']}]  {entry.get('timestamp', '')}")
    elif args.passphrase:
        print(generate_passphrase())
    else:
        if args.length < 4:
            raise SystemExit("Error: length must be at least 4")
        pool = build_pool()
        pw = generate_password(args.length, pool)
        bits = entropy(args.length, len(pool))
        label = strength_label(bits)
        if args.save:
            save_to_history(pw, args.length, bits, label)
        print(f"{pw}  [{label}]")
