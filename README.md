# calculator-asm
Graphical REPL Calculator made in x64 assambly for Windows

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
