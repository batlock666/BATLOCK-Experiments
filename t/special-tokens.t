#!/usr/bin/perl -T

#: special-tokens.t:
#:	Some of the special tokens available in Perl.
#:

use strict;
use warnings;
use 5.006;

use Test::More tests => 3;

{
    package Foo::Package;

    sub get_package {
        # Special token __PACKAGE__ is the current package
        return __PACKAGE__;
    }

    sub get_file {
        # Special token __FILE__ is the current file
        my $f = __FILE__;
        $f =~ s/.*\///;
        return $f;
    }

    sub get_line {
        # Special token __LINE__ is the current line number
        return __LINE__;
    }
}

## Tests
ok(Foo::Package::get_package() eq 'Foo::Package',
   'Special token __PACKAGE__');
ok(Foo::Package::get_file() eq 'special-tokens.t',
   'Special token __FILE__');
ok(Foo::Package::get_line() == 30,
   'Special token __LINE__');
