#! /usr/bin/perl -T

#: list-comprehensions.t:
#:	List comprehensions in Perl.
#:

use 5.006;
use strict;
use warnings;

use Test::More tests => 4;

my @foo_array = (0..7);

# Filter the array
my @foo_filt = grep { $_ % 2 } @foo_array;

# Map the array
my @foo_map = map { $_ * $_ } @foo_array;

# Combine both operations
my @foo_comb = map { $_ * $_ } grep { $_ % 2 } @foo_array;

# Create a hashtable
my %foo_hash = map { 'foo' . $_ => $_ * 2 } grep { $_ % 2 } @foo_array;

## Tests
is_deeply(
    \@foo_filt,
    [1, 3, 5, 7],
    'Filter the array');
is_deeply(
    \@foo_map,
    [0, 1, 4, 9, 16, 25, 36, 49],
    'Map the array');
is_deeply(
    \@foo_comb,
    [1, 9, 25, 49],
    'Combine both operations');
is_deeply(
    \%foo_hash,
    {foo1 => 2, foo3 => 6, foo5 => 10, foo7 => 14},
    'Create a hashtable');
