"""Generate a random password."""
import argparse
import math
import random
import string

DIGITS = string.digits
LOWERCASE = string.ascii_lowercase
UPPERCASE = string.ascii_uppercase
SYMBOLS = "!@#$%^&*()-_=+[]{};:,.<>?"
AMBIGUOUS = "Il1O0o"

def build_pool(use_digits=True, use_lower=True, use_upper=True, use_symbols=True, no_ambiguous=False):
    """Build the character pool from enabled classes."""
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
    """Calculate password entropy in bits."""
    if pool_size <= 1:
        return 0
    return length * math.log2(pool_size)

def strength_label(bits):
    """Return a human-readable strength label."""
    if bits < 40:
        return "WEAK"
    elif bits < 60:
        return "FAIR"
    else:
        return "STRONG"

def generate_password(length, pool):
    """Generate a single random password."""
    return "".join(random.choice(pool) for _ in range(length))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    args = parser.parse_args()
    if args.length < 4:
        raise SystemExit("Error: length must be at least 4")
    pool = build_pool()
    pw = generate_password(args.length, pool)
    bits = entropy(args.length, len(pool))
    label = strength_label(bits)
    print(f"{pw}  [{label}]")
