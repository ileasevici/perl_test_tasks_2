use strict;
use warnings;

package Cat;
use base 'Animal';

sub change_weight {
    my ( $self, $dif_weight ) = @_;

    my $new_weight = $self->{_weight} + $dif_weight;
    $self->{_weight} = $new_weight  if defined($new_weight);

    return $self->SUPER::get_weight();
}

1;