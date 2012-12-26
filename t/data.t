use Modern::Perl;
use Test::More;
use Encode;
use Encode::ISO5426;
use utf8;

my $expected = "aèà0";
my $got
    = Encode::decode 'ISO-5426'
    , Encode::encode 'ISO-5426'
    , $expected;

is $got, $expected, "utf-8 to ISO-5426";
done_testing;

# Add more test here!
