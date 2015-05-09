#!/usr/bin/perl -T

#: monkey-patching.t:
#:	Monkeypatching functions in packages.
#:

use strict;
use warnings;
use 5.006;

use Test::More tests => 3;

{
    package Foo::Package;

    sub foo1_sub {
        return 'foo';
    }

    sub foo2_sub {
        return 'foo';
    }

    sub foo3_sub {
        return 'foo';
    }
}

# Patched function
{
    # Replace the function
    no warnings 'redefine';
    *Foo::Package::foo2_sub = sub {
        return 'bar';
    };
}

# Patched function, calling the original
{
    # Get the original function
    my $foo3_orig = \&Foo::Package::foo3_sub;

    # Replace the function
    no warnings 'redefine';
    *Foo::Package::foo3_sub = sub {
        return &$foo3_orig() . 'bar';
    }
}

## Tests
ok(Foo::Package::foo1_sub() eq 'foo',
   'Unpatched function');
ok(Foo::Package::foo2_sub() eq 'bar',
   'Patched function');
ok(Foo::Package::foo3_sub() eq 'foobar',
   'Patched function, calling the original');
