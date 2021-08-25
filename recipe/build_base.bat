set LIB=%LIBRARY_LIB%;%LIB%
set LIBPATH=%LIBRARY_LIB%;%LIBPATH%
set INCLUDE=%LIBRARY_INC%;%INCLUDE%
rem Resolves MSB4175: The task factory "CodeTaskFactory" could not be loaded from the assembly
set VisualStudioVersion=

ECHO [directories] > mplsetup.cfg
ECHO basedirlist = %LIBRARY_PREFIX% >> mplsetup.cfg
ECHO [packages] >> mplsetup.cfg
ECHO tests = False >> mplsetup.cfg
ECHO sample_data = False >> mplsetup.cfg
ECHO toolkits_tests = False >> mplsetup.cfg
ECHO [libs] >> mplsetup.cfg
ECHO system_freetype = False >> mplsetup.cfg

set MPLSETUPCFG=mplsetup.cfg

rem Unpack cached copy of freetype 2.6.1 source
%PYTHON% -c "import os,tarfile;os.makedirs('build', exist_ok=True);tgz = tarfile.open(os.environ['RECIPE_DIR'] + '/freetype-2.6.1.tar.bz2', mode='r:bz2');tgz.extractall('build')"

%PYTHON% -m pip install . --no-deps -vv
if errorlevel 1 exit 1
