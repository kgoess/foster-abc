INSTALLATION

1) Look at the settings in the Makefile

2) Look at the settings in the config component.

3) Add to your httpd.conf something like this:

    PerlSetVar MasonCompRoot /home/httpd/html/foster-abc
    PerlSetVar MasonDataDir /home/httpd/html/foster-abc/mason
    PerlSetVar MasonUseDataCache 1
    PerlModule HTML::Mason::ApacheHandler
    <Location /foster-abc>
        SetHandler perl-script
        PerlHandler HTML::Mason::ApacheHandler
    </Location>
    <LocationMatch "(dhandler|autohandler)$">
        SetHandler perl-script
        PerlInitHandler Apache::Constants::NOT_FOUND
    </LocationMatch>
    <Location /foster-abc/images>
        SetHandler default
    </Location>

