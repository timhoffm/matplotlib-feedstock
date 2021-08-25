#!/bin/bash

cat <<EOF > conda_mpl_config.cfg
[directories]
basedirlist = $PREFIX

[packages]
tests = False
toolkit_tests = False
sample_data = False

[libs]
system_freetype = False

EOF

cat conda_mpl_config.cfg
sed -i.bak "s|/usr/local|${PREFIX}|" setupext.py

if [[ "$target_platform" == linux* ]]; then
  export AR=$GCC_AR
  export RANLIB=$GCC_RANLIB
fi

$PYTHON -c "import os,tarfile;os.makedirs('build', exist_ok=True);tgz = tarfile.open(os.environ['RECIPE_DIR'] + '/freetype-2.6.1.tar.bz2', mode='r:bz2');tgz.extractall('build')"

export MPLSETUPCFG=conda_mpl_config.cfg

$PYTHON -m pip install . --no-deps -vv
