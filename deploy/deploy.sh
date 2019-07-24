mkdir -p /srv/pillar/drbd
cp -R pillar/* /srv/pillar
cp ../pillar.example /srv/pillar/drbd/formula.sls

mkdir -p /srv/salt/drbd
cp -R salt/* /srv/salt
cp -R ../drbd /srv/salt
