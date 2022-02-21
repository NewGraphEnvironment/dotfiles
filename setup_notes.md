# Apple computer setup

## First steps (manual)

- log in etc
- enable tap to click
- install homebrew

		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

- add brew to path for zsh and bash:

		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/snorris/.zprofile
		eval "$(/opt/homebrew/bin/brew shellenv)"	

		echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.bash_profile && source ~/.bash_profile

- switch between zsh / bash defaults

		chsh -s /bin/bash
		chsh -s /bin/zsh

- download setup scripts

		mkdir -p ~/Projects/repo && cd ~/Projects/repo 
		git clone https://github.com/smnorris/dotfiles.git && cd dotfiles

- install brew stuff

		./brew.sh

- quit out of terminal, use sublime to customize scripts, run scripts in iterm2

		source bootstrap.sh
		./.macos

## accounts etc

- log into chrome, sync once
- add apple and google accounts
- download 1password, add chrome extension, enable safari extension

## teams, citrix

manual installs

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


