# mac GIS setup notes

## checklist

- vwmare
- windows/arcgis
- mail
- projects
- data
- backups


## QGIS
- install manually as per qgis.org download page (including python 3.6 and gdal)
- add xyz maps by pasting this into python terminal: https://raw.githubusercontent.com/klakar/QGIS_resources/master/collections/Geosupportsystem/python/qgis_basemaps.py


## Vmware

- download win 10 image
- create new vm with the win 10 image
- add to mac's pg_hba.conf (not sure what the 2nd one refers to? maybe the watershed's network??:
```
host    all             all             192.168.0.0/16          md5
host    all             all             24.68.143.188/16        md5
```
- add to `postgresql.conf`:
`listen_addresses = '*'`

In VMWare, point to the server by editing the hosts file (C:\Windows\System32\drivers\etc)
]see https://stackoverflow.com/questions/3235011/vmware-fusion-connecting-to-hosts-web-server-from-guest/19824282#19824282 (so good)


