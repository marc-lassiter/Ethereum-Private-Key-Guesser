# Ethereum-Private-Key-Guesser
A simple bash private key guesser for the Ethereum network for experimental purposes.

Current flow:
- Generates a random 64 character hex -> geth account import with that random hex acting as the private key -> parses results -> checks the balance of the address imported via a localhost ethereum node -> if a balance was found it writes the information to a log file

Things that may be nice to add:
- A counter, so you know how many addresses you've checked
- Imporve performence

Feel free to mess around with the code / contribute changes.
