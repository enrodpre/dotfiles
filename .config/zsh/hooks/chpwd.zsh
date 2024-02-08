#!/bin/zsh

function react_to_venv() {

    if [[ -d ".venv" ]];
    then 
        VENV_ROOTDIR=$(pwd)
        source .venv/bin/activate 
        # PYVENVPATH=$VIRTUAL_ENV/bin/python
        # VENVMODULES=$VIRTUAL_ENV/lib/python3.12/site-packages
        PROJECTSOURCE=$VENV_ROOTDIR/src
        export PYTHONPATH=$PYTHONPATH:$PROJECTSOURCE
        export MYPYPATH=$VENV_ROOTDIR
    fi > /dev/null 2>&1

    [[ $PWD != ${VENV_ROOTDIR}* ]] && deactivate > /dev/null 2>&1
}
