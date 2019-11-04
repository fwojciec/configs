export LC_ALL=en_US.UTF-8

if [[ "$(umask)" = "000" ]]; then
    umask 022
fi
