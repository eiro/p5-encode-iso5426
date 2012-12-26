# SYNOPSIS 

this is a WIP ISO-5426 ucm (Unicode Char Map) for ICU

# Build Encode::ISO5426

    enc2xs -M ISO5426 iso-5426.ucm
    perl Makefile.PL
    make
    make test
    make install

Then

    my $expected = "aèà0";
    my $got
        = Encode::decode 'ISO-5426'
        , Encode::encode 'ISO-5426'
        , $expected;

or even 

    open my $datafile,'<:encoding(ISO5426)','datafile.mrc';

# Add more test here!

I'll release it on CPAN when it will be more tested
