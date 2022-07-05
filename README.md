password-strength
=======
Script to demonstrate password strength interactively as a teaching tool

Requirements
------------
bash
cracklib

Usage
------------

```
./password-strength.sh
```
This will run the script without outputting the password. You can use the verbose option to
output the password as the person types each character.
```
./password-strength.sh verbose

Output Example
------------
```
Password: password
Cracklib: password: it is based on a dictionary word
Length: 8 Number: No UpperCase: No LowerCase: Yes SpecialCharacter: No
1
POOR PASSWORD

Type <Ctrl>+C to exit this script
````

