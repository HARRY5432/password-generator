"""Generate a random password."""
import random
import string
import sys

DIGITS = string.digits
LOWERCASE = string.ascii_lowercase
UPPERCASE = string.ascii_uppercase
SYMBOLS = "!@#$%^&*()-_=+[]{};:,.<>?"

def generate_password(length=12):
    """Generate a single random password."""
    chars = LOWERCASE + UPPERCASE + DIGITS + SYMBOLS
    return "".join(random.choice(chars) for _ in range(length))

if __name__ == "__main__":
    length = int(sys.argv[1]) if len(sys.argv) > 1 else 12
    print(generate_password(length))
