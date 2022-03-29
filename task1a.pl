use strict;

sub bubbleSort {
    my @arr = @_;

    for( @arr ) {
        for( my $i = 0; $i < @arr - 1; $i++ ) {
            @arr[$i, $i+1] = @arr[$i+1, $i] if @arr[$i] > @arr[$i+1];
        }
    }
    return @arr;
}

sub search {
    my ( $search, @arr ) = @_;
    
    my @id = ( undef, $#arr, 0 );
    while ( @id[-1] <= $id[1] ) {
        @id[0] = int((@id[-1] + @id[1]) / 2);

        return "MATCH\n" if (@arr[$id[0]] == $search);

        ($search < @arr[$id[0]]) ? ($id[1] = $id[0] - 1) : ($id[-1] = $id[0] + 1);
    }

    return "NOT_MATCH\n";
}

my @unsorted = ( qw/ 7 1 3 4 2 4 6 5 5 / );
my $search = 4;

my $result = search($search, bubbleSort(@unsorted));
print "$result";