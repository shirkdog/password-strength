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
```

Output Example
------------
```
Password: password
Cracklib: password: it is based on a dictionary word
Length: 8 Number: No UpperCase: No LowerCase: Yes SpecialCharacter: No
1
POOR PASSWORD

Type <Ctrl>+C to exit this script

Password: asdfasdf
Cracklib: asdfasdf: it does not contain enough DIFFERENT characters
Length: 8 Number: No UpperCase: No LowerCase: Yes SpecialCharacter: No
1
POOR PASSWORD

Type <Ctrl>+C to exit this script

Password: 2gdXLFSMF0a^>CRk
Cracklib: 2gdXLFSMF0a^>CRk: OK
Length: 16 Number: Yes UpperCase: Yes LowerCase: Yes SpecialCharacter: Yes
6
GOOD PASSWORD

Type <Ctrl>+C to exit this script

````

