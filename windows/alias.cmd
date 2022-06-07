@echo off
cd %~dp0

echo @%2 > %1.cmd

echo "Alias %1 created to call '%2'"
@echo on