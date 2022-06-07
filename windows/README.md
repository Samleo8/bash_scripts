# Command Aliases in Windows

## First Steps

1) If you have admin rights, create a folder named "aliases" somewhere and add that to path
2) Go to command prompt and type `echo %PATH%`. Find some path where you can add a file inside without admin rights, and add these `.cmd` files to that path. Usually it's from a program like `git` that's installed from the Windows store.
3) Add these files to path

## How to create a command or alias

### Using the now created alias command
If you have moved the `.cmd` files into a PATH accessible folder as described above, then simply use the `alias` command as follows:

```cmd
> alias <COMMAND_NAME> <COMMAND_TO_RUN>
```

Dealiasing is also supported: `dealias <COMMAND_NAME>`

Otherwise, you can create a `.cmd` file named after your alias in the folder from , like ls.cmd, then in that file type the command you want. for example `ls.cmd` will look like:

```cmd
@dir /B %*
```

The `@` symbol is there to suppress the output of the command. If you are writing a multiline command script, you can also use `@echo off` to suppress the output of the command, and `@echo on` to turn echoing back on.
