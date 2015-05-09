#!/usr/bin/perl -T

#: python-decorators.t:
#:	Implement Python decorators using attribute handlers.
#:

use strict;
use warnings;
use 5.006;

use Test::More tests => 4;

{
    # Attribute handlers are defined in their own package
    package Foo::Package;

    # This module makes defining attribute handlers easier
    use Attribute::Handlers;

    # Define a simple decorator
    sub foo1_deco :ATTR(CODE) {
        # Default arguments
        my ($pkg, $sym, $code) = @_;

        # Replace the function
        no warnings 'redefine';
        *{$sym} = sub {
            return $code->(@_) x 2;
        };
    }

    # Define a decorator with an argument
    sub foo2_deco :ATTR(CODE) {
        # Default arguments
        my ($pkg, $sym, $code, $name, $args) = @_;

        # Replace the function
        no warnings 'redefine';
        *{$sym} = sub {
            my $count = $args->[0];
            return $code->(@_) x $count;
        };
    }
}

# Using attribute handlers requires subclassing
use base 'Foo::Package';

# No decorator
sub foo1_sub {
    my $str = $_[0];
    return $str;
}

# Simple decorator
sub foo2_sub :foo1_deco {
    my $str = $_[0];
    return $str;
}

# Decorator with an argument
sub foo3_sub :foo2_deco(3) {
    my $str = $_[0];
    return $str;
}

# Stacked decorators
sub foo4_sub :foo1_deco :foo2_deco(3) {
    my $str = $_[0];
    return $str;
}

## Tests
ok(foo1_sub('foo') eq 'foo',
   'No decorator');
ok(foo2_sub('foo') eq 'foofoo',
   'Simple decorator');
ok(foo3_sub('foo') eq 'foofoofoo',
   'Decorator with an argument');
ok(foo4_sub('foo') eq 'foofoofoofoofoofoo',
   'Stacked decorators');
