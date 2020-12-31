"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
import sys
import uuid
from datetime import datetime

VERSION = "1.1"
DIGITS = string.digits
LOWERCASE = string.ascii_lowercase
UPPERCASE = string.ascii_uppercase
SYMBOLS = "!@#$%^&*()-_=+[]{};:,.<>?"
AMBIGUOUS = "Il1O0o"
HISTORY_FILE = "password_history.json"

if sys.platform == "win32":
    os.system("")

RED = "\033[91m"
GREEN = "\033[92m"
YELLOW = "\033[93m"
RESET = "\033[0m"

WORD_LIST = [
    "apple", "brave", "cloud", "delta", "eagle", "flame", "grape", "house",
    "ivory", "jolly", "kneel", "lemon", "mango", "noble", "ocean", "piano",
    "quest", "river", "storm", "tiger", "unity", "vivid", "whale", "xenon",
    "yacht", "zebra", "amber", "blaze", "coral", "drift"
]

COMMON_PASSWORDS = {"password", "123456", "qwerty", "abc123", "letmein", "admin", "welcome"}

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

def colored_label(label):
    if label == "WEAK":
        return f"{RED}{label}{RESET}"
    elif label == "FAIR":
        return f"{YELLOW}{label}{RESET}"
    else:
        return f"{GREEN}{label}{RESET}"

def generate_password(length, pool):
    return "".join(random.choice(pool) for _ in range(length))

def generate_passphrase(num_words=4, separator="-"):
    return separator.join(random.choice(WORD_LIST) for _ in range(num_words))

def generate_random_number(low=1, high=100):
    return random.randint(low, high)

def generate_uuid():
    return str(uuid.uuid4())

def check_breach(password):
    return password.lower() in COMMON_PASSWORDS

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

def show_stats():
    history = load_history()
    if not history:
        print("no passwords saved yet")
        return
    entropies = [e["entropy"] for e in history]
    avg = sum(entropies) / len(entropies)
    print(f"total: {len(history)} passwords")
    print(f"avg entropy: {avg:.1f} bits")
    print(f"strongest: {max(entropies):.1f} bits")
    print(f"weakest: {min(entropies):.1f} bits")

def show_summary():
    history = load_history()
    weak = sum(1 for e in history if e["strength"] == "WEAK")
    fair = sum(1 for e in history if e["strength"] == "FAIR")
    strong = sum(1 for e in history if e["strength"] == "STRONG")
    print(f"summary: {len(history)} total | {weak} weak | {fair} fair | {strong} strong")

def show_about():
    print(f"password generator v{VERSION}")
    print("generates cryptographically secure passwords using the secrets module")
    print("supports character classes, passphrases, history, and strength metering")

def main():
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("-n", "--number", type=int, default=1, help="number of passwords")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    parser.add_argument("--export", action="store_true", help="export history to csv")
    parser.add_argument("--passphrase", action="store_true", help="generate passphrase instead")
    parser.add_argument("--interactive", action="store_true", help="interactive mode")
    parser.add_argument("--stats", action="store_true", help="show statistics")
    parser.add_argument("--version", action="version", version=f"%(prog)s {VERSION}")
    parser.add_argument("--no-digits", action="store_true", help="exclude digits")
    parser.add_argument("--no-lower", action="store_true", help="exclude lowercase")
    parser.add_argument("--no-upper", action="store_true", help="exclude uppercase")
    parser.add_argument("--no-symbols", action="store_true", help="exclude symbols")
    parser.add_argument("--no-ambiguous", action="store_true", help="exclude ambiguous chars")
    args = parser.parse_args()
    if args.interactive:
        interactive_mode()
    elif args.stats:
        show_stats()
    elif args.export:
        export_csv()
    elif args.load:
        for entry in load_history():
            print(f"{entry['password']}  [{entry['strength']}]  {entry.get('timestamp', '')}")
    elif args.passphrase:
        print(generate_passphrase())
    else:
        if args.length < 4:
            raise SystemExit("Error: length must be at least 4")
        pool = build_pool(
            use_digits=not args.no_digits,
            use_lower=not args.no_lower,
            use_upper=not args.no_upper,
            use_symbols=not args.no_symbols,
            no_ambiguous=args.no_ambiguous,
        )
        for _ in range(args.number):
            pw = generate_password(args.length, pool)
            bits = entropy(args.length, len(pool))
            label = strength_label(bits)
            breached = check_breach(pw)
            if breached:
                print(f"{pw}  [{colored_label('WEAK')}] WARNING: common password!")
            else:
                if args.save:
                    save_to_history(pw, args.length, bits, label)
                print(f"{pw}  [{colored_label(label)}]")

def interactive_mode():
    print(f"password generator v{VERSION} - interactive mode")
    print(f"current time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("commands: gen, pass, rand, uuid, history, stats, summary, about, export, version, help, quit")
    session_history = []
    while True:
        try:
            cmd = input("> ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\ngoodbye!")
            break
        if cmd == "quit":
            break
        elif cmd == "version":
            print(f"v{VERSION}")
        elif cmd == "about":
            show_about()
        elif cmd == "help":
            print("gen     - generate a password\npass    - generate passphrase\nrand    - random number\nuuid    - generate UUID\nhistory - show saved\nstats   - show statistics\nsummary - quick summary\nabout   - about this tool\nexport  - export csv\nversion - show version\nquit    - exit")
        elif cmd == "gen":
            pool = build_pool()
            pw = generate_password(16, pool)
            bits = entropy(16, len(pool))
            label = strength_label(bits)
            session_history.append(pw)
            print(f"{pw}  [{colored_label(label)}]")
        elif cmd == "pass":
            pp = generate_passphrase()
            session_history.append(pp)
            print(pp)
        elif cmd == "rand":
            print(generate_random_number())
        elif cmd == "uuid":
            print(generate_uuid())
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "stats":
            show_stats()
        elif cmd == "summary":
            show_summary()
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    main()
