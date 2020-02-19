"""Generate a random password."""
import random
import string
import sys

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
    length = int(sys.argv[1]) if len(sys.argv) > 1 else 12
    print(generate_password(length))
