#!/usr/bin/perl -w

#http://unix.stackexchange.com/questions/8414/how-to-have-tail-f-show-colored-output


#tail -f *.log | ctail
#tail -f *.log -f **/*.log | ctail
while(<STDIN>) {
    my $line = $_;
    chomp($line);
    for($line){
        s/==>.*<==/\e[1;44m$&\e[0m/gi; #tail multiples files name in blue background
        s/.*error .*|at .*/\e[0;31m$&\e[0m/gi;  #java errors & stacktraces in red
        s/.*warn .*/\e[1;33m$&\e[0m/gi; #warning replacement in yellow
    }
    print $line, "\n";
}
