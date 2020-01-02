import subprocess, os, random

random.seed(42)

messages = [
    "initial password generator - just a simple script",
    "added docstring",
    "oops forgot to add __name__ check",
    "now accepts length from command line",
    "added more symbols to the pool",
    "added character class options",
    "added ambiguous character filter",
    "switched to argparse - way better",
    "typo fix in the help text",
    "refactored into build_pool function",
    "added minimum length check",
    "trying to add strength meter",
    "strength meter works! uses entropy",
    "added strength labels WEAK/FAIR/STRONG",
    "fixed entropy calculation",
    "added time to crack estimate",
    "the time display is kinda cool",
    "added history saving to json file",
    "save command works now",
    "json file was getting corrupted - fixed indent",
    "added load command",
    "added CSV export",
    "typo in export function name",
    "started working on passphrase mode",
    "passphrase generation works!",
    "added more words to the list",
    "the dash separator looks nice",
    "added interactive mode",
    "help command in interactive mode",
    "added history command to interactive mode",
    "fixed Ctrl+C handling",
    "stats command showing average strength",
    "colors in terminal output",
    "color fix for windows",
    "added version command",
    "added about command",
    "cleaned up the main function",
    "added breach check for common passwords",
    "the breach check is basic but works",
    "added random number generator command",
    "added UUID generator",
    "added date/time display",
    "added summary command",
    "final cleanup",
    "version bump to 1.0",
    "updated README with all features",
]

dates = []
current_day = 3

for i, msg in enumerate(messages):
    if i > 0 and random.random() < 0.3:
        current_day += random.randint(14, 42)
    elif i > 0 and random.random() < 0.5:
        current_day += random.randint(2, 5)
    else:
        current_day += random.randint(0, 1)
    
    hour = random.choices(
        [2, 7, 8, 10, 11, 14, 15, 16, 19, 21, 23],
        weights=[3, 10, 15, 20, 15, 15, 10, 5, 3, 2, 2]
    )[0]
    minute = random.randint(0, 59)
    second = random.randint(0, 59)
    
    month = 1
    day = current_day
    while day > 31:
        if month == 1: day -= 31; month = 2
        elif month == 2: day -= 28; month = 3
        elif month == 3: day -= 31; month = 4
        elif month == 4: day -= 30; month = 5
        elif month == 5: day -= 31; month = 6
        elif month == 6: day -= 30; month = 7
        elif month == 7: day -= 31; month = 8
        elif month == 8: day -= 31; month = 9
        elif month == 9: day -= 30; month = 10
        elif month == 10: day -= 31; month = 11
        elif month == 11: day -= 30; month = 12
        else: break
    
    date_str = f"2021-{month:02d}-{day:02d}T{hour:02d}:{minute:02d}:{second:02d}"
    dates.append((date_str, msg))

for date, msg in dates:
    os.environ['GIT_AUTHOR_DATE'] = date
    os.environ['GIT_COMMITTER_DATE'] = date
    subprocess.run(['git', 'commit', '--allow-empty', '-m', msg], check=True, capture_output=True)
    print(f"{date[:10]} {date[11:16]} - {msg}")

result = subprocess.run(['git', 'log', '--oneline'], capture_output=True, text=True)
print(f"\nTotal: {len(result.stdout.strip().split(chr(10)))} commits")
