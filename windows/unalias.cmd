@echo off
cd %~dp0

del %1.cmd
echo "Removed alias '%1'"
@echo on