#!/usr/bin/perl -T

#: dynamic-packages.t:
#:	Create packages in runtime.
#:

use strict;
use warnings;
use 5.006;

use Test::More tests => 2;

# Dynamic package
my $foo_str = 'foo';
{
    # Define the package
    my $foo_code = <<ENDOFFOO;
package Foo::Package;

use strict;
use warnings;

sub foo_sub {
    return '$foo_str';
}
ENDOFFOO

    # Evaluate the package
    eval($foo_code);
}

# Dynamic object-oriented package
my $bar_str = 'bar';
{
    # Define the object-oriented package
    my $bar_code = <<ENDOFBAR;
package Bar::Package;

use strict;
use warnings;

sub new {
    my \$cls = shift;
    return bless {}, \$cls;
}

sub bar_sub {
    my \$self = shift;
    return '$bar_str';
}
ENDOFBAR

    # Evaluate the object-oriented package
    eval($bar_code);
}

## Tests
ok(Foo::Package::foo_sub() eq $foo_str,
   'Dynamic package');

my $bar_obj = Bar::Package->new();
ok($bar_obj->bar_sub() eq $bar_str,
   'Dynamic object-oriented package');
