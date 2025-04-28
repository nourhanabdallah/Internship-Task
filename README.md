# :writing_hand: Internship-Task

# 🛠️ mygrep.sh - A Mini Version of `grep` in Bash

## 📄 Description
`mygrep.sh` is a lightweight Bash script that mimics basic features of the Linux `grep` command.  
It allows you to **search** through files for a specific string (case-insensitive), with options to **show line numbers** and **invert the match**.

---

## 🚀 Features
- **Case-insensitive search** (default behavior)
- **Show line numbers** with `-n`
- **Invert match** (show non-matching lines) with `-v`
- **Combined options** supported (e.g., `-vn` or `-nv`)
- **Help message** with `--help`
- **Error handling** for missing arguments and files

---

## 🧰 Usage

```bash
./mygrep.sh [options] search_string filename
```
---

## :white_check_mark:  Hands-On Validation:
1.  `./mygrep.sh hello testfile.txt ` :

   
     ![image](https://github.com/user-attachments/assets/7f06abad-b81c-498c-a51d-3c4e4aa09fa9)


3. `./mygrep.sh -n hello testfile.txt` :

     ![image](https://github.com/user-attachments/assets/a5f7ee02-5b9c-463b-8267-809f7aa5ac6d)

4. ` ./mygrep.sh -vn hello testfile.txt`

     ![image](https://github.com/user-attachments/assets/0c660a5b-01ec-4680-8e93-e549070838aa)

5. ` ./mygrep.sh -v testfile.txt (expect: script should warn about missing search string)`


     ![image](https://github.com/user-attachments/assets/a369fbaa-9616-4860-9800-6a53a41a915a)


---

## 🧠 Reflective Section

### 1. how the script handles arguments and options

- **Initialization**:
  - `show_line_numbers` and `invert_match` are set to `false` by default.

- **Option Parsing**:
  - A `while` loop checks if the first argument starts with a dash (`-`).
  - The `case` statement handles individual options:
    - `-n` enables line numbers.
    - `-v` enables inverted match.
    - `--help` displays usage instructions and exits.
  - For combined options like `-vn` or `-nv`, a nested `for` loop parses each character individually and sets flags accordingly.

- **Argument Validation**:
  - After parsing options, the script expects exactly two positional arguments:
    - **Search string** (what you want to find)
    - **Filename** (where you want to search)
  - If either is missing, it prints an error and exits.

- **File Check**:
  - The script checks if the specified file exists. If not, it outputs an error message and stops execution.

- **File Processing**:
  - Reads the file line-by-line.
  - Converts both the line and the search string to lowercase to ensure case-insensitive matching.
  - Decides whether to print the line based on the match result and inversion flag (`-v`).
  - Optionally prefixes the output with line numbers if `-n` was set.

---

### 2. how would the structure change If I were to support regex or `-i`/`-c`/`-l` options ?

- **Regex Support**:
  - Instead of using `[[ "$line" =~ "$search_string" ]]`, I'd allow full regex matching using tools like `grep -E` internally, or adjust Bash's regular expression handling. I would need careful escaping of special characters.

- **`-i` (case-insensitive)**:
  - I would introduce a new flag `ignore_case`, and only convert the line and pattern to lowercase if this flag is active, instead of doing it by default.

- **`-c` (count matches)**:
  - Instead of printing each line immediately, I would maintain a counter variable and increment it for each match. At the end of the script, I would print only the final count.

- **`-l` (list filenames)**:
  - I would simply print the filename once if there is at least one matching line and then stop further processing for that file.

- **Option Parsing Changes**:
  - I'd definitely replace manual option parsing with `getopts` (Bash built-in tool) to handle many options more cleanly and consistently.

---

### 3. What part of the script was hardest to implement and why?

`getopts`, a built-in Bash tool for more robust and cleaner option parsing,
  Its not hard but i Don't know before so, its a new added information for me 
---

## :sparkles: Some Advanced Tips for usage :
* Adding the script in variable:$PATH to be run anywhere as a built in command :

  ![image](https://github.com/user-attachments/assets/4f250e98-99f4-48ba-b17c-9c68c7b5b6a9)

*`the only thing would change here the logic of filename to be replaced with the pwd path to search in  all files if fileneme doesn't given like generic grep command  `*
  
