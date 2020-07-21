# MissingLink Broken Link SEO Monitor (Shell Script)

█▀▄▀█ ▄█    ▄▄▄▄▄    ▄▄▄▄▄   ▄█    ▄     ▄▀      █    ▄█    ▄   █  █▀ 
█ █ █ ██   █     ▀▄ █     ▀▄ ██     █  ▄▀        █    ██     █  █▄█   
█ ▄ █ ██ ▄  ▀▀▀▀▄ ▄  ▀▀▀▀▄   ██ ██   █ █ ▀▄      █    ██ ██   █ █▀▄   
█   █ ▐█  ▀▄▄▄▄▀   ▀▄▄▄▄▀    ▐█ █ █  █ █   █     ███▄ ▐█ █ █  █ █  █  
    █   ▐                      ▐ █  █ █  ███          ▀ ▐ █  █ █   █   
    ▀                             █   ██        v0.3a      █   ██  ▀    


MissingLink is a shell script which uses [pylinkvalidor by bartdag](https://github.com/bartdag/pylinkvalidator) to monitor a list of websites for broken links. It can be run on a schedule as part of SEO checks.

Broken links are bad for SEO, but it's hard to track broken links if you have many websites filled with dozens of pieces of written content.

MissingLink generates both a clean report list, and a full crawl list of sources so you can find the anchor relative to the broken link.

## Quick Start

Install pylinkvalidator 

```bash
pip install pylinkvalidator
```

Configure the list of domains to crawl. Be sure to always leave a blank line at the end of the file.

```bash
nano cfg/domains.txt
```

Run MissingLink and wait for it to finish the crawl.
```bash
./run.sh
```

## Usage

There are a few options which you can configure throughout the script. 

Under Opening Variables, you can configure the depth parameter to control crawl depth. For moost blogs three is enough, however you may want to let it run for 5-10 for a first time crawl to be sure. 

```bash
depth=3
```

If any of your links are having HTTP/HTTPS-related issues, look at the following line. You could also append a subdomain to this variable to match a pattern.

```bash
target="https://$url"
```

You can disable any link type under ```#Print main crawl``` to prevent verbosity and control link / image / script types. 