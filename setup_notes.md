# Apple computer setup

## First steps (manual)

- log in etc
- enable tap to click
- install homebrew

		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

- add brew to path for zsh and bash:

		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/airvine/.zprofile
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

Create a GitHub personal access token:
    https://github.com/settings/tokens/new?scopes=gist,repo,workflow&description=Homebrew
  echo 'export HOMEBREW_GITHUB_API_TOKEN=your_token_here' >> ~/.zshrc

		./bootstrap.sh
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

# Curl
Updated curl with brew install curl
it gave me this message so this is what I did

If you need to have curl first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/curl/bin:$PATH"' >> ~/.zshrc

For compilers to find curl you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/curl/include"

For pkg-config to find curl you may need to set:
  export PKG_CONFIG_PATH="/opt/homebrew/opt/curl/lib/pkgconfig"


# General Environmental Variables for Gorbs

You can edit your .bash_profile in your home directory (`/Users/airvine`).  After you edit the file you need to run it fo the changes to take place. 

    source ~/.bash_profile

Still figuring it our but it seems that Rstudio has it's own environment so it can't always access global variables. I am a bit lost by it all. you can use `usethis::edit_r_environ()` to see and edit R specific variable that will run in all your sessions...  They look like this:

    DO_SPACES_REGION="sfo3"

  
# Zotero

    brew install zotero  
    
copy over library from old machine to new `Users/airvine/zotero`- this is the default location
install betterbibtex - 'citation key format' is:  

    [auth.etal:lower:replace=.,_][>0][year][veryshorttitle2]|[title][year]
    
  * in better bibtex settings `Export/BibTex` check Export unicode as plain-test and "Add URLs to BibTex export: setting = "in the 'url' field""
    
install Zotfile.  Settings in Zotfile `Tools/ZotFile Preferences/Renaming Rules/ Use Zotero to Rename is *checked** with default:  

    {%a_}{%y_}{%t}
    
  * other defaults are already checked.
    
We don't need to point to `Users/airvine/zotero` since it is the default https://www.zotero.org/support/zotero_data#restoring_your_zotero_data_from_a_backup 

We set it up to sync just our shared libraries on Zotero.

# Digital Ocean Droplets and custom domain
https://docs.digitalocean.com/tutorials/dns-registrars/#registrar-google-domains
follow link to the setup from there

https://docs.digitalocean.com/products/networking/dns/how-to/manage-records/
https://docs.digitalocean.com/products/networking/dns/how-to/add-subdomain/


# Git

So when we transfer to the mac we want to set auto-detect line endings for each repo we copied over to the mac from windows if we don't want git status to think all our files have changed. We don't want to do this globally because of https://github.com/mathiasbynens/dotfiles/issues/149 

    git config --local core.autocrlf true
    
git config file lives in repo directory in .git/config

# Java

    https://www.azul.com/downloads/?package=jdk#download-openjdk
    https://cdn.azul.com/zulu/bin/zulu11.56.19-ca-jdk11.0.15-macosx_aarch64.dmg

    
# gmailr

Setup instructions at 

    https://github.com/r-lib/gmailr 
    https://developers.google.com/workspace/guides/create-project
    https://developers.google.com/gmail/api
    
    
made a new environment to install the python tools

    conda create -n gmailr
    conda activate gmailr
    pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib
    
getting error - something is wrong with my entire setup.  prob need to tear everything down and start over :(

  `WARNING: There was an error checking the latest version of pip.`
  
    mkdir quickstart
    
In here I had to store my credentials for the gmail api downloaded from google console into the `gmailr/quickstart` folder and renamed `credentials.json`.
    
    
# Moving files around

    mv /Volumes/backup_2022/backups/new_graph/archive/safety/ /Users/airvine/projects/current/ 

# Setting postgres on Digital Ocean

built a custom script to setup postgres with brew on DO machine.  The prep is done with 0600-pg-analogsea in `setup-pg-2022` and the rest is done from this repo with `install_geo_linux.sh`


