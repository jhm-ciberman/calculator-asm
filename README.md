# calculator-asm
Graphical REPL Calculator made in x64 assambly for Windows

## Commands

To execute a command type it and press enter. All commands are **case insensitive**: 

- `help`: Shows this readme file
- `exit`: Closes the application
- `zoom+`: Increases the GUI size
- `zoom-`: Decreases the GUI size
- `clear`: Clear the previous command log

The calculator uses polish inverse notation. For example, you can type:

```
> 3 2 + .
5
```

Explanation: This command introduces a `3` onto the stack, then a `2`. Then the `+` operation removes the last 
two elements from the stack and add them together and push the result (`5`) back onto the stack. Lastly, 
the `.` operator, removes the last element from the stack (`5`) and prints the result on the screen.

The possible operands are the following:

### Binary operators
All binary operators remove the two values at the top of the stack, perform the operation and put the result back onto the stack.
- `+` : Adition.
- `-` : Substraction
- `*` : Multiplication
- `/` : Integer division
- `%` : Integer division remainder
- `OR` : Logic OR
- `AND` : Logic AND
- `XOR` : Logic XOR (Exclusive OR)

### Unary operators
Unary operators removes the topmost value from the stack and puts the result 
back onto the stack.
- `NOT` : Bitwise negation (Negates each bit of the integer)
- `NEG` : Integer negation. If the number is positive, this calculate the negative, and if the number is negative this will convert it into a positive number.

### Print operators
This operators will print values in the console
- `.` : Removes the topmost value of the stack and prints it on the screen in decimal
- `.h` : Removes the topmost value of the stack and prints it on the screen in hexadecimal
- `.b` : Removes the topmost value of the stack and prints it on the screen in binary
- `s.` : Prints ALL the stack (from top to bottom) without consuming any value

## Building from source

Setup Flat Assambler: 
1. Download [Flat Assambler](https://flatassembler.net/download.php) for windows and 
    place the folder somewhere near the root of your disk. Eg: `C:\fasm\`.
2. Add the `C:\fasm\` to your `PATH`
3. Add the environment variable `INCLUDE` with the value `C:\fasm\include` to point to the FASM included files.

Cloning the repor and setup Visual Studio code: (optional)

1. Clone the repo and download [Visual Studio Code](https://code.visualstudio.com/)
2. Press `Ctrl+Shift+B` to show the building tasks. Select "Build And Run Graphical" or "Build And Run Logic"
    to build the full REPL calculator or only the console version.

If you don't want to use Visual Studio Code as your IDE, you can build the project manually from the command line:

```
fasm .\src\main-graphic.asm .\calc.exe
```

## Authors

- Ivan Rodriguez
- Javier "Ciberman" Mora

Made for the "Computer Architecture I" assignment for FASTA University, Mar del Plata, Argentina.

## License 

MIT
