#!/usr/bin/env perl

BEGIN { use lib 't'; require 'testlib.pl'; }

use Modern::Perl;

# Test https://github.com/z88dk/z88dk/issues/2298
# z80asm: Incorrect/misleading compiler error when ZCCCFG not set

delete $ENV{ZCCCFG};

spew("$test.c", "int main() {}");
capture_nok("zcc +zx -vn $test.c -o $test.bin -lndos2", <<END);
error: file not found: ndos2.lib
END

spew("$test.asm", "nop");
capture_nok("z88dk-z80asm -b -l$test $test.asm", <<END);
error: file not found: $test.lib
END

unlink_testfiles;
done_testing;
