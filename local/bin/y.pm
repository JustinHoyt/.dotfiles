package y;
use strict;
use warnings;

use List::Util qw(
    any
    all
    none
    notall
    first
    max
    maxstr
    min
    minstr
    product
    reduce
    shuffle
    sum
    sum0
    pairs
    unpairs
    pairkeys
    pairvalues
    pairfirst
    pairgrep
    pairmap
    sample
    uniq
    uniqint
    uniqnum
    uniqstr
    head
    tail
    zip
    mesh
);

use Cpanel::JSON::XS;
use Exporter 'import';

our @EXPORT = qw(
    any
    all
    none
    notall
    first
    max
    maxstr
    min
    minstr
    product
    reduce
    shuffle
    sum
    sum0
    pairs
    unpairs
    pairkeys
    pairvalues
    pairfirst
    pairgrep
    pairmap
    sample
    uniq
    uniqint
    uniqnum
    uniqstr
    head
    tail
    zip
    mesh
    encode_json
    decode_json
);

1;

