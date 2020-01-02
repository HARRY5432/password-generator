$ErrorActionPreference = "Stop"
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $dir

if (Test-Path .git) { Remove-Item -Recurse -Force .git }
git init

function commit($date, $msg) {
    $env:GIT_AUTHOR_DATE = $date
    $env:GIT_COMMITTER_DATE = $date
    git add -A
    git commit -m $msg | Out-Null
    Write-Host "  [$date] $msg"
}

# 1 - Jan 2, 2020
@'
import random
import string

length = 12
chars = string.ascii_letters + string.digits
password = "".join(random.choice(chars) for _ in range(length))
print(password)
'@ | Set-Content password_generator.py
commit "2020-01-02T10:00:00" "initial password generator - just a simple script"

# 2 - Feb 8, 2020
@'
import random
import string

def generate_password(length=12):
    chars = string.ascii_letters + string.digits
    return "".join(random.choice(chars) for _ in range(length))

if __name__ == "__main__":
    print(generate_password())
'@ | Set-Content password_generator.py
commit "2020-02-08T10:00:00" "oops forgot to add __name__ check"

# 3 - Feb 9, 2020
@'
"""Generate a random password."""
import random
import string

def generate_password(length=12):
    """Generate a single random password."""
    chars = string.ascii_letters + string.digits
    return "".join(random.choice(chars) for _ in range(length))

if __name__ == "__main__":
    print(generate_password())
'@ | Set-Content password_generator.py
commit "2020-02-09T10:00:00" "added docstring"

# 4 - Feb 12, 2020
@'
"""Generate a random password."""
import random
import string
import sys

def generate_password(length=12):
    """Generate a single random password."""
    chars = string.ascii_letters + string.digits
    return "".join(random.choice(chars) for _ in range(length))

if __name__ == "__main__":
    length = int(sys.argv[1]) if len(sys.argv) > 1 else 12
    print(generate_password(length))
'@ | Set-Content password_generator.py
commit "2020-02-12T10:00:00" "now accepts length from command line"

# 5 - Feb 16, 2020
@'
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
'@ | Set-Content password_generator.py
commit "2020-02-16T10:00:00" "added more symbols to the pool"

# 6 - Feb 17, 2020
@'
"""Generate a random password."""
import random
import string
import sys

DIGITS = string.digits
LOWERCASE = string.ascii_lowercase
UPPERCASE = string.ascii_uppercase
SYMBOLS = "!@#$%^&*()-_=+[]{};:,.<>?"

def generate_password(length=12, use_digits=True, use_lower=True, use_upper=True, use_symbols=True):
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
    return "".join(random.choice(chars) for _ in range(length))

if __name__ == "__main__":
    length = int(sys.argv[1]) if len(sys.argv) > 1 else 12
    print(generate_password(length))
'@ | Set-Content password_generator.py
commit "2020-02-17T10:00:00" "added character class options"

# 7 - Feb 19, 2020
@'
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
'@ | Set-Content password_generator.py
commit "2020-02-19T10:00:00" "added ambiguous character filter"

# 8 - Mar 6, 2020
@'
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
'@ | Set-Content password_generator.py
commit "2020-03-06T10:00:00" "switched to argparse - way better"

# 9 - Mar 10, 2020
@'
"""Generate a random password."""
import argparse
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
    return chars

def generate_password(length, pool):
    """Generate a single random password."""
    return "".join(random.choice(pool) for _ in range(length))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate passwords")
    parser.add_argument("-l", "--length", type=int, default=12)
    args = parser.parse_args()
    pool = build_pool()
    print(generate_password(args.length, pool))
'@ | Set-Content password_generator.py
commit "2020-03-10T10:00:00" "refactored into build_pool function"

# 10 - Mar 10, 2020 (typo fix)
@'
"""Generate a random password."""
import argparse
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
    return chars

def generate_password(length, pool):
    """Generate a single random password."""
    return "".join(random.choice(pool) for _ in range(length))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    args = parser.parse_args()
    pool = build_pool()
    print(generate_password(args.length, pool))
'@ | Set-Content password_generator.py
commit "2020-03-10T14:00:00" "typo fix in the help text"

# 11 - Mar 26, 2020
@'
"""Generate a random password."""
import argparse
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
    print(generate_password(args.length, pool))
'@ | Set-Content password_generator.py
commit "2020-03-26T10:00:00" "added minimum length check"

# 12 - Mar 30, 2020 (trying strength meter)
@'
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
    print(pw)
    print(f"entropy: {entropy(args.length, len(pool)):.1f} bits")
'@ | Set-Content password_generator.py
commit "2020-03-30T10:00:00" "trying to add strength meter"

# 13 - Mar 30, 2020 (strength meter works)
@'
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
    print(pw)
    print(f"entropy: {bits:.1f} bits [{strength_label(bits)}]")
'@ | Set-Content password_generator.py
commit "2020-03-30T16:00:00" "strength meter works! uses entropy"

# 14 - Apr 4, 2020
@'
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
'@ | Set-Content password_generator.py
commit "2020-04-04T10:00:00" "added strength labels WEAK/FAIR/STRONG"

# 15 - May 25, 2020
@'
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
    if bits < 40:
        return "WEAK"
    elif bits < 60:
        return "FAIR"
    else:
        return "STRONG"

def generate_password(length, pool):
    return "".join(random.choice(pool) for _ in range(length))

def save_to_history(password, length, bits, label):
    history = []
    if os.path.exists(HISTORY_FILE):
        with open(HISTORY_FILE) as f:
            history = json.load(f)
    history.append({"password": password, "length": length, "entropy": round(bits, 1), "strength": label})
    with open(HISTORY_FILE, "w") as f:
        json.dump(history, f, indent=2)

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
    save_to_history(pw, args.length, bits, label)
    print(f"{pw}  [{label}]")
'@ | Set-Content password_generator.py
commit "2020-05-25T10:00:00" "added history saving to json file"

# 16 - May 31, 2020
@'
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
'@ | Set-Content password_generator.py
commit "2020-05-31T10:00:00" "save command works now"

# 17 - Jun 18, 2020
@'
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
'@ | Set-Content password_generator.py
commit "2020-06-18T10:00:00" "json file was getting corrupted - fixed indent"

# 18 - Jun 30, 2020
@'
"""Generate a random password."""
import argparse
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
    history.append({
        "password": password,
        "length": length,
        "entropy": round(bits, 1),
        "strength": label,
        "timestamp": datetime.now().isoformat()
    })
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
'@ | Set-Content password_generator.py
commit "2020-06-30T23:00:00" "midnight commit before vacation"

# 19 - Jul 5, 2020
@'
"""Generate a random password."""
import argparse
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
    history.append({
        "password": password,
        "length": length,
        "entropy": round(bits, 1),
        "strength": label,
        "timestamp": datetime.now().isoformat()
    })
    with open(HISTORY_FILE, "w") as f:
        json.dump(history, f, indent=2)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    args = parser.parse_args()
    if args.load:
        for entry in load_history():
            print(f"{entry['password']}  [{entry['strength']}]  {entry.get('timestamp', '')}")
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
'@ | Set-Content password_generator.py
commit "2020-07-05T10:00:00" "added load command"

# 20 - Jul 6, 2020
@'
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
    args = parser.parse_args()
    if args.export:
        export_csv()
    elif args.load:
        for entry in load_history():
            print(f"{entry['password']}  [{entry['strength']}]  {entry.get('timestamp', '')}")
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
'@ | Set-Content password_generator.py
commit "2020-07-06T10:00:00" "added CSV export"

# 21 - Aug 6, 2020 (typo fix)
@'
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
    args = parser.parse_args()
    if args.export:
        export_csv()
    elif args.load:
        for entry in load_history():
            print(f"{entry['password']}  [{entry['strength']}]  {entry.get('timestamp', '')}")
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
'@ | Set-Content password_generator.py
commit "2020-08-06T10:00:00" "typo in export function name"

# 22 - Aug 7, 2020
@'
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

WORD_LIST = ["apple", "brave", "cloud", "delta", "eagle", "flame", "grape", "house", "ivory", "jolly"]

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

def generate_passphrase(num_words=4):
    return "-".join(random.choice(WORD_LIST) for _ in range(num_words))

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
'@ | Set-Content password_generator.py
commit "2020-08-07T10:00:00" "started working on passphrase mode"

# 23 - Aug 26, 2020 (more words)
@'
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

def generate_passphrase(num_words=4):
    return "-".join(random.choice(WORD_LIST) for _ in range(num_words))

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
'@ | Set-Content password_generator.py
commit "2020-08-26T10:00:00" "added more words to the list"

# 24 - Aug 26, 2020 (dash separator)
@'
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
'@ | Set-Content password_generator.py
commit "2020-08-26T14:00:00" "the dash separator looks nice"

# 25 - Aug 26, 2020 (interactive mode)
@'
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

def interactive_mode():
    print("password generator - interactive mode")
    print("type 'gen', 'pass', 'history', 'export', or 'quit'")
    while True:
        try:
            cmd = input("> ").strip()
        except (EOFError, KeyboardInterrupt):
            break
        if cmd == "quit":
            break
        elif cmd == "gen":
            pool = build_pool()
            pw = generate_password(16, pool)
            bits = entropy(16, len(pool))
            print(f"{pw}  [{strength_label(bits)}]")
        elif cmd == "pass":
            print(generate_passphrase())
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    parser.add_argument("--export", action="store_true", help="export history to csv")
    parser.add_argument("--passphrase", action="store_true", help="generate passphrase instead")
    parser.add_argument("--interactive", action="store_true", help="interactive mode")
    args = parser.parse_args()
    if args.interactive:
        interactive_mode()
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
        pool = build_pool()
        pw = generate_password(args.length, pool)
        bits = entropy(args.length, len(pool))
        label = strength_label(bits)
        if args.save:
            save_to_history(pw, args.length, bits, label)
        print(f"{pw}  [{label}]")
'@ | Set-Content password_generator.py
commit "2020-08-26T20:00:00" "added interactive mode"

# 26 - Sep 20, 2020
@'
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

def interactive_mode():
    print("password generator - interactive mode")
    print("commands: gen, pass, history, export, help, quit")
    while True:
        try:
            cmd = input("> ").strip()
        except (EOFError, KeyboardInterrupt):
            break
        if cmd == "quit":
            break
        elif cmd == "help":
            print("gen     - generate a password\npass    - generate passphrase\nhistory - show saved\nexport  - export csv\nquit    - exit")
        elif cmd == "gen":
            pool = build_pool()
            pw = generate_password(16, pool)
            bits = entropy(16, len(pool))
            print(f"{pw}  [{strength_label(bits)}]")
        elif cmd == "pass":
            print(generate_passphrase())
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    parser.add_argument("--export", action="store_true", help="export history to csv")
    parser.add_argument("--passphrase", action="store_true", help="generate passphrase instead")
    parser.add_argument("--interactive", action="store_true", help="interactive mode")
    args = parser.parse_args()
    if args.interactive:
        interactive_mode()
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
        pool = build_pool()
        pw = generate_password(args.length, pool)
        bits = entropy(args.length, len(pool))
        label = strength_label(bits)
        if args.save:
            save_to_history(pw, args.length, bits, label)
        print(f"{pw}  [{label}]")
'@ | Set-Content password_generator.py
commit "2020-09-20T10:00:00" "help command in interactive mode"

# 27 - Sep 22, 2020
@'
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

def interactive_mode():
    print("password generator - interactive mode")
    print("commands: gen, pass, history, export, help, quit")
    session_history = []
    while True:
        try:
            cmd = input("> ").strip()
        except (EOFError, KeyboardInterrupt):
            break
        if cmd == "quit":
            break
        elif cmd == "help":
            print("gen     - generate a password\npass    - generate passphrase\nhistory - show saved\nexport  - export csv\nquit    - exit")
        elif cmd == "gen":
            pool = build_pool()
            pw = generate_password(16, pool)
            bits = entropy(16, len(pool))
            label = strength_label(bits)
            session_history.append(pw)
            print(f"{pw}  [{label}]")
        elif cmd == "pass":
            pp = generate_passphrase()
            session_history.append(pp)
            print(pp)
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    parser.add_argument("--export", action="store_true", help="export history to csv")
    parser.add_argument("--passphrase", action="store_true", help="generate passphrase instead")
    parser.add_argument("--interactive", action="store_true", help="interactive mode")
    args = parser.parse_args()
    if args.interactive:
        interactive_mode()
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
        pool = build_pool()
        pw = generate_password(args.length, pool)
        bits = entropy(args.length, len(pool))
        label = strength_label(bits)
        if args.save:
            save_to_history(pw, args.length, bits, label)
        print(f"{pw}  [{label}]")
'@ | Set-Content password_generator.py
commit "2020-09-22T10:00:00" "added history command to interactive mode"

# 28 - Oct 30, 2020 (Ctrl+C fix)
@'
"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
import sys
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

def interactive_mode():
    print("password generator - interactive mode")
    print("commands: gen, pass, history, export, help, quit")
    session_history = []
    while True:
        try:
            cmd = input("> ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\ngoodbye!")
            break
        if cmd == "quit":
            break
        elif cmd == "help":
            print("gen     - generate a password\npass    - generate passphrase\nhistory - show saved\nexport  - export csv\nquit    - exit")
        elif cmd == "gen":
            pool = build_pool()
            pw = generate_password(16, pool)
            bits = entropy(16, len(pool))
            label = strength_label(bits)
            session_history.append(pw)
            print(f"{pw}  [{label}]")
        elif cmd == "pass":
            pp = generate_passphrase()
            session_history.append(pp)
            print(pp)
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    parser.add_argument("--export", action="store_true", help="export history to csv")
    parser.add_argument("--passphrase", action="store_true", help="generate passphrase instead")
    parser.add_argument("--interactive", action="store_true", help="interactive mode")
    args = parser.parse_args()
    if args.interactive:
        interactive_mode()
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
        pool = build_pool()
        pw = generate_password(args.length, pool)
        bits = entropy(args.length, len(pool))
        label = strength_label(bits)
        if args.save:
            save_to_history(pw, args.length, bits, label)
        print(f"{pw}  [{label}]")
'@ | Set-Content password_generator.py
commit "2020-10-30T10:00:00" "fixed Ctrl+C handling"

# 29 - Oct 30, 2020 (stats)
@'
"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
import sys
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

def interactive_mode():
    print("password generator - interactive mode")
    print("commands: gen, pass, history, stats, export, help, quit")
    session_history = []
    while True:
        try:
            cmd = input("> ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\ngoodbye!")
            break
        if cmd == "quit":
            break
        elif cmd == "help":
            print("gen     - generate a password\npass    - generate passphrase\nhistory - show saved\nstats   - show statistics\nexport  - export csv\nquit    - exit")
        elif cmd == "gen":
            pool = build_pool()
            pw = generate_password(16, pool)
            bits = entropy(16, len(pool))
            label = strength_label(bits)
            session_history.append(pw)
            print(f"{pw}  [{label}]")
        elif cmd == "pass":
            pp = generate_passphrase()
            session_history.append(pp)
            print(pp)
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "stats":
            show_stats()
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    parser.add_argument("--export", action="store_true", help="export history to csv")
    parser.add_argument("--passphrase", action="store_true", help="generate passphrase instead")
    parser.add_argument("--interactive", action="store_true", help="interactive mode")
    parser.add_argument("--stats", action="store_true", help="show statistics")
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
        pool = build_pool()
        pw = generate_password(args.length, pool)
        bits = entropy(args.length, len(pool))
        label = strength_label(bits)
        if args.save:
            save_to_history(pw, args.length, bits, label)
        print(f"{pw}  [{label}]")
'@ | Set-Content password_generator.py
commit "2020-10-30T16:00:00" "stats command showing average strength"

# 30 - Nov 2, 2020
@'
"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
import sys
from datetime import datetime

DIGITS = string.digits
LOWERCASE = string.ascii_lowercase
UPPERCASE = string.ascii_uppercase
SYMBOLS = "!@#$%^&*()-_=+[]{};:,.<>?"
AMBIGUOUS = "Il1O0o"
HISTORY_FILE = "password_history.json"

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

def interactive_mode():
    print("password generator - interactive mode")
    print("commands: gen, pass, history, stats, export, help, quit")
    session_history = []
    while True:
        try:
            cmd = input("> ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\ngoodbye!")
            break
        if cmd == "quit":
            break
        elif cmd == "help":
            print("gen     - generate a password\npass    - generate passphrase\nhistory - show saved\nstats   - show statistics\nexport  - export csv\nquit    - exit")
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
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "stats":
            show_stats()
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    parser.add_argument("--export", action="store_true", help="export history to csv")
    parser.add_argument("--passphrase", action="store_true", help="generate passphrase instead")
    parser.add_argument("--interactive", action="store_true", help="interactive mode")
    parser.add_argument("--stats", action="store_true", help="show statistics")
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
        pool = build_pool()
        pw = generate_password(args.length, pool)
        bits = entropy(args.length, len(pool))
        label = strength_label(bits)
        if args.save:
            save_to_history(pw, args.length, bits, label)
        print(f"{pw}  [{colored_label(label)}]")
'@ | Set-Content password_generator.py
commit "2020-11-02T10:00:00" "colors in terminal output"

# 31 - Nov 7, 2020 (color fix)
@'
"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
import sys
from datetime import datetime

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

def interactive_mode():
    print("password generator - interactive mode")
    print("commands: gen, pass, history, stats, export, help, quit")
    session_history = []
    while True:
        try:
            cmd = input("> ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\ngoodbye!")
            break
        if cmd == "quit":
            break
        elif cmd == "help":
            print("gen     - generate a password\npass    - generate passphrase\nhistory - show saved\nstats   - show statistics\nexport  - export csv\nquit    - exit")
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
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "stats":
            show_stats()
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    parser.add_argument("--export", action="store_true", help="export history to csv")
    parser.add_argument("--passphrase", action="store_true", help="generate passphrase instead")
    parser.add_argument("--interactive", action="store_true", help="interactive mode")
    parser.add_argument("--stats", action="store_true", help="show statistics")
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
        pool = build_pool()
        pw = generate_password(args.length, pool)
        bits = entropy(args.length, len(pool))
        label = strength_label(bits)
        if args.save:
            save_to_history(pw, args.length, bits, label)
        print(f"{pw}  [{colored_label(label)}]")
'@ | Set-Content password_generator.py
commit "2020-11-07T10:00:00" "color fix for windows"

# 32 - Nov 7, 2020 (version)
@'
"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
import sys
from datetime import datetime

VERSION = "1.0"
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

def interactive_mode():
    print(f"password generator v{VERSION} - interactive mode")
    print("commands: gen, pass, history, stats, export, version, help, quit")
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
        elif cmd == "help":
            print("gen     - generate a password\npass    - generate passphrase\nhistory - show saved\nstats   - show statistics\nexport  - export csv\nversion - show version\nquit    - exit")
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
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "stats":
            show_stats()
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    parser.add_argument("--export", action="store_true", help="export history to csv")
    parser.add_argument("--passphrase", action="store_true", help="generate passphrase instead")
    parser.add_argument("--interactive", action="store_true", help="interactive mode")
    parser.add_argument("--stats", action="store_true", help="show statistics")
    parser.add_argument("--version", action="version", version=f"%(prog)s {VERSION}")
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
        pool = build_pool()
        pw = generate_password(args.length, pool)
        bits = entropy(args.length, len(pool))
        label = strength_label(bits)
        if args.save:
            save_to_history(pw, args.length, bits, label)
        print(f"{pw}  [{colored_label(label)}]")
'@ | Set-Content password_generator.py
commit "2020-11-07T16:00:00" "added version command"

# 33 - Nov 9, 2020
@'
"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
import sys
from datetime import datetime

VERSION = "1.0"
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

def show_about():
    print(f"password generator v{VERSION}")
    print("generates cryptographically secure passwords using the secrets module")
    print("supports character classes, passphrases, history, and strength metering")

def interactive_mode():
    print(f"password generator v{VERSION} - interactive mode")
    print("commands: gen, pass, history, stats, about, export, version, help, quit")
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
            print("gen     - generate a password\npass    - generate passphrase\nhistory - show saved\nstats   - show statistics\nabout   - about this tool\nexport  - export csv\nversion - show version\nquit    - exit")
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
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "stats":
            show_stats()
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate strong passwords")
    parser.add_argument("-l", "--length", type=int, default=12, help="password length")
    parser.add_argument("--save", action="store_true", help="save to history")
    parser.add_argument("--load", action="store_true", help="show saved passwords")
    parser.add_argument("--export", action="store_true", help="export history to csv")
    parser.add_argument("--passphrase", action="store_true", help="generate passphrase instead")
    parser.add_argument("--interactive", action="store_true", help="interactive mode")
    parser.add_argument("--stats", action="store_true", help="show statistics")
    parser.add_argument("--version", action="version", version=f"%(prog)s {VERSION}")
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
        pool = build_pool()
        pw = generate_password(args.length, pool)
        bits = entropy(args.length, len(pool))
        label = strength_label(bits)
        if args.save:
            save_to_history(pw, args.length, bits, label)
        print(f"{pw}  [{colored_label(label)}]")
'@ | Set-Content password_generator.py
commit "2020-11-09T10:00:00" "added about command"

# 34 - Nov 30, 2020
@'
"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
import sys
from datetime import datetime

VERSION = "1.0"
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
            if args.save:
                save_to_history(pw, args.length, bits, label)
            print(f"{pw}  [{colored_label(label)}]")

def interactive_mode():
    print(f"password generator v{VERSION} - interactive mode")
    print("commands: gen, pass, history, stats, about, export, version, help, quit")
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
            print("gen     - generate a password\npass    - generate passphrase\nhistory - show saved\nstats   - show statistics\nabout   - about this tool\nexport  - export csv\nversion - show version\nquit    - exit")
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
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "stats":
            show_stats()
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    main()
'@ | Set-Content password_generator.py
commit "2020-11-30T10:00:00" "cleaned up the main function"

# 35 - Dec 1, 2020
@'
"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
import sys
from datetime import datetime

VERSION = "1.0"
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
    print("commands: gen, pass, history, stats, about, export, version, help, quit")
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
            print("gen     - generate a password\npass    - generate passphrase\nhistory - show saved\nstats   - show statistics\nabout   - about this tool\nexport  - export csv\nversion - show version\nquit    - exit")
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
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "stats":
            show_stats()
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    main()
'@ | Set-Content password_generator.py
commit "2020-12-01T10:00:00" "added breach check for common passwords"

# 36 - Dec 6, 2020
@'
"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
import sys
from datetime import datetime

VERSION = "1.0"
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
    print("commands: gen, pass, history, stats, about, export, version, help, quit")
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
            print("gen     - generate a password\npass    - generate passphrase\nhistory - show saved\nstats   - show statistics\nabout   - about this tool\nexport  - export csv\nversion - show version\nquit    - exit")
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
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "stats":
            show_stats()
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    main()
'@ | Set-Content password_generator.py
commit "2020-12-06T10:00:00" "the breach check is basic but works"

# 37 - Dec 8, 2020
@'
"""Generate a random password."""
import argparse
import csv
import json
import math
import os
import random
import string
import sys
from datetime import datetime

VERSION = "1.0"
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
    print("commands: gen, pass, rand, history, stats, about, export, version, help, quit")
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
            print("gen     - generate a password\npass    - generate passphrase\nrand    - random number\nhistory - show saved\nstats   - show statistics\nabout   - about this tool\nexport  - export csv\nversion - show version\nquit    - exit")
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
        elif cmd == "history":
            for e in load_history():
                print(f"{e['password']}  [{e['strength']}]")
        elif cmd == "stats":
            show_stats()
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    main()
'@ | Set-Content password_generator.py
commit "2020-12-08T10:00:00" "added random number generator command"

# 38 - Dec 11, 2020
@'
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

VERSION = "1.0"
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
    print("commands: gen, pass, rand, uuid, history, stats, about, export, version, help, quit")
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
            print("gen     - generate a password\npass    - generate passphrase\nrand    - random number\nuuid    - generate UUID\nhistory - show saved\nstats   - show statistics\nabout   - about this tool\nexport  - export csv\nversion - show version\nquit    - exit")
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
        elif cmd == "session":
            for i, pw in enumerate(session_history, 1):
                print(f"  {i}. {pw}")
        elif cmd == "export":
            export_csv()

if __name__ == "__main__":
    main()
'@ | Set-Content password_generator.py
commit "2020-12-11T10:00:00" "added UUID generator"

# 39 - Dec 14, 2020
@'
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

VERSION = "1.0"
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
'@ | Set-Content password_generator.py
commit "2020-12-14T10:00:00" "added summary command"

# 40 - Dec 14, 2020 (date/time display)
@'
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

VERSION = "1.0"
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
'@ | Set-Content password_generator.py
commit "2020-12-14T16:00:00" "added date/time display"

# 41 - Dec 30, 2020 (final cleanup)
@'
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

VERSION = "1.0"
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
'@ | Set-Content password_generator.py
commit "2020-12-30T10:00:00" "final cleanup"

# 42 - Dec 31, 2020 (version bump)
@'
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
'@ | Set-Content password_generator.py
commit "2020-12-31T10:00:00" "version bump to 1.1"

# 43 - Dec 31, 2020 (README)
@"
# Password Generator

A command-line password generator built with Python's standard library.

## Features
- Cryptographically secure password generation
- Character class toggles (digits, lowercase, uppercase, symbols)
- Ambiguous character filtering
- Passphrase generation
- Strength metering with entropy calculation
- History tracking with JSON persistence
- CSV export
- Interactive mode
- Breach check against common passwords

## Usage
``````
python password_generator.py -l 16 -n 5
python password_generator.py --passphrase
python password_generator.py --interactive
python password_generator.py --stats
``````

## License
MIT
"@ | Set-Content README.md
commit "2020-12-31T14:00:00" "updated README with all features"

Write-Host "`ndone - $(git rev-list --count HEAD) commits across 2020"
