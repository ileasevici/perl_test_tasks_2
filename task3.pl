use strict;
use warnings;

my $datetime = "2016-04-11 20:59:03";

my ($date) = $datetime =~ /^((\d{4})-(\d{2})-(\d{2}))/;
my ($time) = $datetime =~ /((\d{2}):(\d{2}):(\d{2})$)/;

# Альтернативные варианты
#my ($date, $time) = $datetime =~ /(.+)\s(.+)/;
#my ($date, $time) = $datetime =~ /(^.{10})\s(.{8}$)/;

print "$date\n";
print "$time\n";
