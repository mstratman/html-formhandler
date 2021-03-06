package HTML::FormHandler::Field::Multiple;
# ABSTRACT: multiple select list

use Moose;
extends 'HTML::FormHandler::Field::Select';
our $VERSION = '0.01';

has '+multiple' => ( default => 1 );
has '+size'     => ( default => 5 );

sub sort_options {
    my ( $self, $options ) = @_;

    return $options unless scalar @$options && defined $self->value;
    my $value = $self->deflate($self->value);
    return $options unless scalar @$value;
    # This places the currently selected options at the top of the list
    # Makes the drop down lists a bit nicer
    my %selected = map { $_ => 1 } @$value;
    my @out = grep { $selected{ $_->{value} } } @$options;
    push @out, grep { !$selected{ $_->{value} } } @$options;
    return \@out;
}

=head1 DESCRIPTION

This inherits from the Select field,
and sets the "multiple" flag true to accept multiple options.

The currently selected items will be put at the top of the list.
Widget type is 'select'.

=cut

__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;
