#!/usr/bin/perl -T

#: changing-class.t:
#:	Changing the class of an object.
#:

use strict;
use warnings;
use 5.006;

use Test::More tests => 4;

# Original class
{
    package Foo::Class;

    use strict;
    use warnings;

    sub new {
        my $cls = shift;
        return bless {}, $cls;
    }

    sub foo_meth {
        my $self = shift;
        return 'foo';
    }
}

# Changed class
{
    package Bar::Class;

    use strict;
    use warnings;

    sub new {
        my $cls = shift;
        return bless {}, $cls;
    }

    sub foo_meth {
        my $self = shift;
        return 'bar';
    }
}

## Tests
my $foo_obj = Foo::Class->new();
ok(ref($foo_obj) eq 'Foo::Class',
   'Original class');
ok($foo_obj->foo_meth() eq 'foo',
   'Method call, with original class');

$foo_obj = bless $foo_obj, 'Bar::Class';
ok(ref($foo_obj) eq 'Bar::Class',
   'Changed class');
ok($foo_obj->foo_meth() eq 'bar',
   'Method call, with changed class');
