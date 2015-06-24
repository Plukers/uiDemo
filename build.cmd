@echo off

PUSHD %~dp0
REM cls

IF exist boot.fsx ( 
"packages\FAKE\tools\Fake.exe" "boot.fsx" 
RM "boot.fsx"
) ELSE ( 
IF exist packages\FAKE ( echo skipping FAKE download ) ELSE ( 
echo downloading FAKE
REM dir
"bin\nuget.exe" "install" "FAKE" "-OutputDirectory" "Packages" "-ExcludeVersion" "-Prerelease"
"bin\nuget.exe" "install" "FSharp.Formatting.CommandTool" "-OutputDirectory" "Packages" "-ExcludeVersion" "-Prerelease"
"bin\nuget.exe" "install" "SourceLink.Fake" "-OutputDirectory" "Packages" "-ExcludeVersion"
"bin\nuget.exe" "install" "NUnit.Runners" "-OutputDirectory" "Packages" "-ExcludeVersion"
"bin\nuget.exe" "install" "Aardvark.Build" "-OutputDirectory" "Packages" "-ExcludeVersion"
"bin\nuget.exe" "install" "Paket.Core" "-OutputDirectory" "packages" "-ExcludeVersion"
)

SET TARGET=Default
IF NOT [%1]==[] (set TARGET=%1)

>tmp ECHO(%*
SET /P t=<tmp
SETLOCAL EnableDelayedExpansion
IF DEFINED t SET "t=!t:%1 =!"
SET args=!t!

"packages\FAKE\tools\Fake.exe" "build.fsx" "target=%TARGET%" %args%
RM tmp
)

