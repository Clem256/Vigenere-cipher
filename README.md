# Vigenère Cipher (COBOL)

A simple console application written in **COBOL** to encrypt and decrypt text using the **Vigenère cipher** algorithm.

---

## Features

- **Encryption & Decryption**: Supports both encoding and decoding modes.
- **Automatic Uppercase Conversion**: Normalizes text and keys to uppercase letters.
- **Non-Alphabetic Characters Preserved**: Spaces, numbers, and punctuation are kept as-is without consuming key letters.
- **Validation**: Rejects empty keys before processing.

---

## Prerequisites

You need a COBOL compiler such as **GnuCOBOL** (`cobc`) installed on your system.

### Install GnuCOBOL

- **Ubuntu / Debian**:
    sudo apt-get install gnucobol

- **macOS (Homebrew)**:
    brew install gnu-cobol

- **Windows**: Available through MinGW or GnuCOBOL binaries.

---

## Build and Run

1. **Compile the source file:**
    cobc -x -o vigenere vigenere.cbl

2. **Run the executable:**
    ./vigenere

---

## Example Usage

    === Choose encryption or decryption ===
    1. Encrypt
    2. Decrypt
    
    === VIGENERE ENCRYPTION ===
    Enter text: 
    HELLO WORLD
    Enter key: 
    KEY
    Encrypted text : RIJVS UYVLD
    Original text  : HELLO WORLD
    Used key       : KEY

---

## Limitations

- Maximum input length for text and key is **50 characters**.
- Accented characters (e.g., é, à, ç) are not supported by standard A-Z arithmetic.
