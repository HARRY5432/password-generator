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
```
python password_generator.py -l 16 -n 5
python password_generator.py --passphrase
python password_generator.py --interactive
python password_generator.py --stats
```

## License
MIT
