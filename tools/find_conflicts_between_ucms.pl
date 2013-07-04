#! /usr/bin/perl
use Modern::Perl;
use YAML;
use Perlude;

my %t;
for my $f
( 'encode-abes/iso5426/iso5426.ucm'
, 'encode-iso5426/iso-5426.ucm' ) {
    now {
        m{ (?<unicode> (?: [<]U....[>] )+ )
            \s+ (?<encode> [^ |]+ )
        }x and push @{ $t{uc $+{unicode} } }
            , { file => $f, encode => uc $+{encode} }
    } lines $f;
}

my %stat;
my %conflicts;

while (my ( $unicode, $data ) = each %t ) {
    my $key = do {
        if ( 1 < @$data ) {
            my %versions =  map { $$_{encode} => 1 } @$data;
            if ( 1 < keys %versions ) {
                my $c = $conflicts{ $unicode } ||= {};
                map { push @{ $$c{ $$_{file} } }, $$_{encode} } @$data;
                my @files_in_trouble = keys %$c;
                $$c{reason} = do {
                    if ( 1 == @files_in_trouble ) { "Inconsistent $files_in_trouble[0]" }
                    else { 'conflicts' }
                };
                $$c{reason};
            } else { 'agreeds' }
        } else { "only in $$data[0]{file}" }
    };
    $stat{$key}++
}


say YAML::Dump
{ stats     => \%stat
, conflicts =>
    [ map {
        $conflicts{$_}{reason} eq 'conflicts'
        ? { $_ => $conflicts{$_} } : () } keys %conflicts ]
}



# say YAML::Dump { %stat, conflict_details => \%conflicts };
