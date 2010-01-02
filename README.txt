abc-fakebook

==================================================

Author: Kevin M. Goess <fosterabc-at-goess.org>

License: This software is released under the GNU
         General Public License, see the "License"
         file accompanying the software.


Requirements:

ABC-Fakebook was developed with the following software:

	Apache 2.2.3
	Perl 5.8.8
	HTML::Mason 1.43
	Ghostscript 8.15.2
	jcabc2ps 20090209
	abcmidi 20091221

THE SOFTWARE IS PROVIDED "AS IS" AND WITHOUT WARRANTIES OF ANY KIND,
INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OF ACCURACY OR
COMPLETENESS OF ANY INFORMATION CONTAINED IN THE SOFTWARE OR IMPLIED
WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.

======================================================

INSTALLATION

1) Look at the settings in the Makefile, and change to suit.

2) Look at the settings in the config component, install the 
   software that's mentioned there, and change to suit.

3) Edit the autohandler component to make your pages look the way 
   you want.

4) Add to your httpd.conf something like this, and restart apache:

    PerlSetVar MasonCompRoot /var/www/html/foster-abc
    PerlSetVar MasonDataDir /var/www/html/foster-abc/mason
    #PerlSetVar MasonUseDataCache 1
    PerlModule HTML::Mason::ApacheHandler
    <Location /foster-abc>
        SetHandler perl-script
        PerlHandler HTML::Mason::ApacheHandler
    </Location>
    <Location /foster-abc/images>
        SetHandler default
    </Location>
    RedirectMatch 404 (dhandler|autohandler)$
    RewriteRule   /mason-data/         / [R]

5) Type 'make install'.

===========================================================

OVERVIEW

The site is set up like this:

	autohandler
	config
	index.html
	abc-src/
		*.abc (the source abc files)
	abc/
		dhandler
	pdf/
		dhandler
	jpg/
		dhandler
	midi/
		dhandler

Requests to urls for abc/, pdf/, jpg/ or midi/ are handled by the dhandler in 
that directory which takes care of generating the requested file and caching
it for future use.



