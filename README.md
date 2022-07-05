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
Password Strength Checker

Password: password
Cracklib: password: it is based on a dictionary word
Score: 1 out of 6

Length: 8 Number: No UpperCase: No LowerCase: Yes SpecialCharacter: No

POOR PASSWORD

Type <Ctrl>+C to exit this script
````

````
Password Strength Checker

Password: P@ssw0rd
Cracklib: P@ssw0rd: it is based on a dictionary word
Score: 4 out of 6

Length: 8 Number: Yes UpperCase: Yes LowerCase: Yes SpecialCharacter: Yes

ALMOST AN OK PASSWORD

Type <Ctrl>+C to exit this script
````

````
Password Strength Checker

Password: asdfasdf
Cracklib: asdfasdf: it does not contain enough DIFFERENT characters
Score: 1 out of 6

Length: 8 Number: No UpperCase: No LowerCase: Yes SpecialCharacter: No

POOR PASSWORD

Type <Ctrl>+C to exit this script
````

````
Password Strength Checker

Password: 2gdXLFSMF0a^>CRk
Cracklib: 2gdXLFSMF0a^>CRk: OK
Score: 6 out of 6

Length: 16 Number: Yes UpperCase: Yes LowerCase: Yes SpecialCharacter: Yes

GOOD PASSWORD

Type <Ctrl>+C to exit this script

````

