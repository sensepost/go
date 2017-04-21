# 1. Name
Go

# 2. Author
Roelof Temmingh

# 3. License, version & release date
License : GPLv2  
Version : v0.1  
Release Date : 2000/12

# 4. Description
Seriously primitive portscanner using Squid proxy.
Can be used to scan ports > 1024 using a "victim" Squid proxy
that is not well configured. For this to work the proxy
needs you to allow to use it. Used to scan machines that
are located behind a firewall, but that is accessible from the proxy

# 5. Usage
> . perl go.pl 160.124.19.103:3128:160.124.19.98:1430:1435

# 6. Requirements
Perl  
Poorly configured Squid proxy
