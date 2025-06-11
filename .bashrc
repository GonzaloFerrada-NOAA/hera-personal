# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

source /scratch1/BMC/gsd-fv3-dev/Gonzalo.Ferrada/miniconda3/etc/profile.d/conda.sh


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# export PS1='\[\033[31m\]${HOSTNAME%%.*}:\[\033[32m\]$(pwd | cut -d/ -f2)\e[0m:$(basename $(dirname $(pwd)))/\W\e[0m> '
# export PS1='\[\033[31m\]${HOSTNAME%%.*}:\[\033[32m\]$(pwd | cut -d/ -f2)\[\033[37m\]:$(basename $(dirname $(pwd)))\[\033[33m\]/\W\e[0m> ' # og causes issues
# export PS1='\[\033[31m\]\h:\[\033[33m\]\W\[\033[0m\]> ' # does not causes issues in terminal
alias ls='ls --color=auto'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
# bind 'set match-hidden-files off'
# bind 'set horizontal-scroll-mode off'

# Only run bind if the shell is interactive
if [[ $- == *i* ]]; then
	bind 'set match-hidden-files off'
	bind 'set horizontal-scroll-mode off'
fi

export TERM=xterm-256color

# Load modules:
module load gnu intel/2023.2.0 ncview/2.1.7
module load netcdf/4.7.0
module load xxdiff
module load nco cdo ncl
module load rocoto
module load wgrib2

# Common aliases:
alias c='clear'
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd.....="cd ../../../.."
alias cd......="cd ../../../../.."
alias cd.......="cd ../../../../../.."
alias kk="ls -ltrh"
alias ll="ls -lh"
alias la="ls -la"
alias l1="ls -1"
alias ld="ls -lhd"
alias reload="source ~/.bashrc; clear"


# Shortcuts:
alias sc0="cd /scratch1/data_untrusted/Gonzalo.Ferrada"
alias sc1="cd /scratch1/BMC/gsd-fv3-dev/Gonzalo.Ferrada"
alias sc2="cd /scratch2/BMC/gsd-fv3-dev/Gonzalo.Ferrada"
alias sc3="cd /scratch3/BMC/gsd-fv3-dev/Gonzalo.Ferrada"
export SC0="/scratch1/data_untrusted/Gonzalo.Ferrada"
export SC1="/scratch1/BMC/gsd-fv3-dev/Gonzalo.Ferrada"
export SC2="/scratch2/BMC/gsd-fv3-dev/Gonzalo.Ferrada"
export SC3="/scratch3/BMC/gsd-fv3-dev/Gonzalo.Ferrada"
alias mate="rmate"
alias acc="saccount_params"
# alias quota="saccount_params"
alias grepi="grep -rnw . -e "
alias grepo="grep -rno . -e "
alias findi="find . -print | grep -i "
alias tf="tail -f "
alias weight="du -skh"
alias ncview="ncview -repl"

# Sudo:
alias rtfim="sudo su - role.rtfim"




# Paths:
PATH="/home/Gonzalo.Ferrada/bin:$PATH"
export PATH

# ------------------------------------------------------
# Application specifics:
# Python:
export PATH=/scratch1/BMC/gsd-fv3-dev/Gonzalo.Ferrada/miniconda3/bin:$PATH
export PYTHONPATH=/scratch1/BMC/gsd-fv3-dev/Gonzalo.Ferrada/HOME/PYTHON/FUNCTIONS

# Matlab:
# MATLABPATH=$( find /home/Gonzalo.Ferrada/MATLAB/FUNCTIONS -type d | awk '{ printf ":%s", $1; }' )
MATLABPATH=/home/Gonzalo.Ferrada/MATLAB/LARGE:${MATLABPATH}
MATLABPATH=/home/Gonzalo.Ferrada/MATLAB/FUNCTIONS:${MATLABPATH}
export MATLABPATH
alias loadmatlab='module load matlab; matlab -nodisplay -nodesktop -nosplash'
alias loadmatlab1='module load matlab; matlab -nodesktop -nosplash'

# Geoweaver:
export GEOWEAVER_PORT=8071

# Github:
GITTOKEN="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"




# Slurm:
alias qsme="date; squeue --user=Gonzalo.Ferrada"
alias qs="date; squeue --start --user=Gonzalo.Ferrada"


# Copy to untrusted data:
# share ()
# {
#   cp -r ${1} /scratch1/data_untrusted/Gonzalo.Ferrada
# }

# queueavail:
qavail ()
{ 
    echo "====================================================================";
    eval "sinfo -N -r -l -p $1";
    echo "====================================================================";
    echo "Nodes allocated   : " $(sinfo -N -r -l -p $1 | grep allocated | wc -l);
    echo "Nodes mixed       : " $(sinfo -N -r -l -p $1 | grep mixed | wc -l);
    echo "Nodes available   : " $(sinfo -N -r -l -p $1 | grep idle | wc -l);
    echo "===================================================================="
}

# update_prompt() {
#     DIR1=$(pwd | cut -d/ -f2)
#     DIR2=$(basename "$(dirname "$(pwd)")")
#     PS1="\[\033[31m\]\h:\[\033[32m\]$DIR1\[\033[37m\]:$DIR2\[\033[33m\]/\W\e[0m> "
# }
#
# PROMPT_COMMAND=update_prompt
# export PS1='\[\033[31m\]\h:\[\033[32m\]\W\[\033[0m\]> '
# export PS1='\[\033[31m\]\h:\[\033[32m\]\u\[\033[37m\]:\[\033[33m\]\W\[\033[0m\]> ' # WORKS!!
# SOLUTION: Works exactly as I want:
update_prompt() {
    DIR1=$(echo "$PWD" | cut -d/ -f2)               # Extract top-level directory
    DIR2=$(basename "$(dirname "$PWD")")           # Extract parent of current directory
    PS1="\[\033[31m\]\h:\[\033[32m\]$DIR1\[\033[37m\]:$DIR2\[\033[33m\]/\W\[\033[0m\]> "
}

PROMPT_COMMAND=update_prompt

# update_prompt() {
#     DIR1=$(echo "$PWD" | cut -d/ -f2)               # Extract top-level directory
#     DIR2=$(basename "$(dirname "$PWD")")           # Extract parent of current directory
#
#     # Clear existing title by sending an empty title first
#     echo -ne "\033]0;\007"
#
#     # Set new terminal title (fully overwriting previous content)
#     echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: $PWD\007"
#
#     # Update the actual prompt
#     PS1="\[\033[31m\]\h:\[\033[32m\]$DIR1\[\033[37m\]:$DIR2\[\033[33m\]/\W\[\033[0m\]> "
# }
#
# PROMPT_COMMAND=update_prompt







export JAVA_HOME="/home/Gonzalo.Ferrada/jdk/jdk-11.0.18+10"
export PATH="$JAVA_HOME/bin:$PATH"
