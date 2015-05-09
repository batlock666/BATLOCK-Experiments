#!/usr/bin/perl -T

#: package-symbols.t:
#:	Accessing a package's symbols.
#:

use strict;
use warnings;
use 5.006;

use Test::More tests => 5;

{
    package Foo::Package;

    use strict;
    use warnings;

    our $foo_scal = 123;
    our @foo_array = ();
    our %foo_hash = ();

    sub foo_sub {
        return;
    }
}

## Tests
my @foo_sym = sort keys %Foo::Package::;
is_deeply(
    \@foo_sym,
    ['BEGIN', 'foo_array', 'foo_hash', 'foo_scal', 'foo_sub'],
    'List the package symbols');

no strict 'refs';
ok(\${'Foo::Package::foo_scal'} == \$Foo::Package::foo_scal,
   'Scalar access');
ok(\@{'Foo::Package::foo_array'} == \@Foo::Package::foo_array,
   'Array access');
ok(\%{'Foo::Package::foo_hash'} == \%Foo::Package::foo_hash,
   'Hash access');
ok(\&{'Foo::Package::foo_sub'} == \&Foo::Package::foo_sub,
   'Function access');
