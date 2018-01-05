use strict;
use warnings;

use Test::More tests => 5;

BEGIN {
    use_ok('CommonMarkGFM');
}

my $md = <<EOF;
# Header

Paragraph *emph*, **strong**

* Item 1
* Item 2
EOF

my $doc = CommonMarkGFM->parse_document($md);
isa_ok($doc, 'CommonMarkGFM::Node', 'parse_document');

my $header = $doc->first_child;
isa_ok($header, 'CommonMarkGFM::Node', 'first_child');
is($doc->first_child, $header, 'first_child returns same node');

my $text = $header->first_child;
$doc    = undef;
$header = undef;
# Cause some allocations.
CommonMarkGFM->parse_document($md)
    for 1..5;
my $literal = $text->get_literal;
is($literal, 'Header', 'doc still exists with no refs to root');

