use strict;
use warnings;

package Animal;

sub new {
    my $class = shift;
    my $self = {
        _type   => shift,
        _name   => shift,
        _weight => shift,
    };

    bless $self, $class;

    return $self;
}

sub get_weight {
    my ( $self ) = @_ ;

    return $self->{_weight};
}

sub set_name {
    my ( $self, $new_name ) = @_;
    
    $self->{_name} = $new_name if defined($new_name);

    return $self->{_name};
}

1;