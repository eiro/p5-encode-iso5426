perl -lnE '
    END { say for sort keys %comb };
    m{
        \s+
        \\x ( \S{2} )
        \\x \S{2}
        \s+
    }gx and $comb{$1}++;
' iso-5426.ucm
