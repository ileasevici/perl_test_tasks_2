use strict;
use warnings;
use lib "./";
require Cat;

my $animal = new Cat('кот', 'Василий', 5);

my $new_name = $animal->set_name("Боня");
my $weight = $animal->get_weight();
my $new_weight = $animal->change_weight( 0.1 );

print "Новое имя животного: $new_name\n";
print "Текущий вес животного: $weight кг.\n";
print "Новый вес животного: $new_weight кг.\n";
