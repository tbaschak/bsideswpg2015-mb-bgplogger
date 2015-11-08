% BGP, some Python, and a DB
% Theodore Baschak
% BSides Winnipeg 2015-11-15

# Slides

> Reveal.js slides [ciscodude.net/presentations/bsideswpg2015-mb-bgplogger](https://ciscodude.net/presentations/bbsideswpg2015-mb-bgplogger)
> 
> Beamer PDF slides [ciscodude.net/presentations/bsideswpg2015-mb-bgplogger.pdf](https://ciscodude.net/presentations/bbsideswpg2015-mb-bgplogger.pdf)

> exabgp-logger daemon project at [github.com/tbaschak/exabgp-logger](https://github.com/tbaschak/exabgp-logger)

# Who Is Theo?

* Network Architect @ Daemon Defense Systems
* Avid Open Source Software user/fanatic, and contributor
* Obsessed with network monitoring and routing
* Involved with several nonprofits in Winnipeg
	1. Board of the Manitoba Internet Exchange (MBIX)
	2. Board of [Coldhak](https://coldhak.ca)
		*	Coldhak is a nonprofit dedicated to furthering privacy, security and freedom of speech

# Overview

* Inspiration
* The idea
* Design
* Building the logger
* Running it
* Peering
* Manitoban Routing
* Scaling it up
* Scaling it futher
* Finding things
* Automating

# Inspiration

* Talked about BGP hijacking in my BSidesWpg 2013 talk
* Dyn Research blogs, formerly Renesys Corporation:
	* 2 days after BSidesWpg 2013, November 19 2013, [Targeted Internet Traffic Misdirection](http://research.dyn.com/2013/11/mitm-internet-hijacking/)
	* March 2015, [UK traffic diverted through Ukraine](http://research.dyn.com/2015/03/uk-traffic-diverted-ukraine/)
* [BGPmon](http://www.bgpmon.net/) & [BGP Stream](https://bgpstream.com/)

# Lightbulb

> ![Edison electric light](https://ciscodude.net/images/2015-11-15-edison.jpg)

# The Idea

* To log BGP updates from various Manitoban sources
	* exabgp seemed like a good starting place
	* a [mailing list post](https://groups.google.com/forum/#!searchin/exabgp-users/route$20collector/exabgp-users/MQDuRNrSCiE/a-jENESfEiwJ) w/ a simple shell collector script
* To examine routes for peering relationships between Manitoban ASNs
* To look at the effects of BGP leaks on Manitoban routing

# Design

* Exabgp (the BGP, and the Python)
	* one process, per AF, per peer (v4 and v6 separate)
	* outputs BGP updates as JSON
* Couchdb (the DB)
	* stores JSON objects
	* one database per peer (v4 and v6 combined)
	* replicate each peer into common DB

# Building

* Uses [exabgp](https://github.com/Exa-Networks/exabgp)
	* Exabgp config defines actions for route input and output
	* Just input in this case, not advertising
	* Bash while loop to read line by line and POST to couchdb

# Running

* Able to run without a peer for basic config checks
* Need a live BGP peer to start viewing BGP update record format
* First tests
	* MFNERC, alpha testing only -- 1 million records
	* First version just cat appended the JSON to a file so I could look at the records
* Growing Pains

# Peering

1. MERLIN -- Gracious statement of support on MBIX-Tech list as well
2. 3T Systems 
3. Les.net
4. Swift High Speed Internet

# MB Routing

* Many common carriers
* Some less common picked up in Toronto, Alberta and Chicago

# Scaling Up

* Moved VM
* Offsite replication
* Increased size of VM and went 64bit

# Finding things

* 

# Automating

* Create a RIB for each peer & AF
* Need to compare updates with RIB
	* Prefix length
	* AS-PATH
* Ability to replay BGP updates from couchdb 


# The End

> Reveal.js slides [ciscodude.net/presentations/bsideswpg2015-mb-bgplogger](https://ciscodude.net/presentations/bbsideswpg2015-mb-bgplogger)
> 
> Beamer PDF slides [ciscodude.net/presentations/bsideswpg2015-mb-bgplogger.pdf](https://ciscodude.net/presentations/bbsideswpg2015-mb-bgplogger.pdf)

> exabgp-logger daemon project at [github.com/tbaschak/exabgp-logger](https://github.com/tbaschak/exabgp-logger)
