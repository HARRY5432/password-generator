"""Generate a random password."""
import argparse
import random
import string

DIGITS = string.digits
LOWERCASE = string.ascii_lowercase
UPPERCASE = string.ascii_uppercase
SYMBOLS = "!@#$%^&*()-_=+[]{};:,.<>?"
AMBIGUOUS = "Il1O0o"

def generate_password(length=12, use_digits=True, use_lower=True, use_upper=True, use_symbols=True, no_ambiguous=False):
    """Generate a single random password."""
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
    return "".join(random.choice(chars) for _ in range(length))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate passwords")
    parser.add_argument("-l", "--length", type=int, default=12)
    args = parser.parse_args()
    print(generate_password(args.length))
