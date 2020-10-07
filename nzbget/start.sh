#!/bin/bash
for file in installer.cfg nzbget.conf; do
    if [ ! -f /config/${file} ]; then
      cp --force /opt/nzbget/${file} /config/${file}
    fi

    ln --symbolic --force /config/${file} /opt/nzbget/${file}
done


for dir in downloads:data scripts:config; do
    parent=${dir#*:}
    child=${dir%:*}

    if [ ! -d /${parent}/${child} ]; then
        install --directory /${parent}/${child}
    fi

    if [ -d /opt/nzbget/${child} ]; then
        cp --recursive --update --force /opt/nzbget/${child}/. /${parent}/${child}
        rm --recursive --force /opt/nzbget/${child}
    fi

    ln --symbolic --force /${parent}/${child} /opt/nzbget/${child}
done

exec /opt/nzbget/nzbget \
    -o outputmode=log \
    -s
