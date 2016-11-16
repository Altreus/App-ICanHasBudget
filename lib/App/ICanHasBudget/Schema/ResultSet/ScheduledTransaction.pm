package App::ICanHasBudget::Schema::ResultSet::ScheduledTransaction;

use strict;
use warnings;
use base qw/DBIx::Class::ResultSet/;

=head1 NAME

App::ICanHasBudget::Schema::ResultSet::ScheduledTransaction - ScheduledTransaction methods

=head1 DESCRIPTION

ResultSet for ScheduledTransaction.

=head1 METHODS

=head2 between

Returns transactions whose next scheduled date is between these two. Accepts
L<Time::Moment> objects. Dates are inclusive.

=cut

sub between {
    my $self = shift;
    my ($earliest, $latest) = @_;
    $self->search({
        -and => [
            { next_occurrence => { '>=' => $earliest } },
            { next_occurrence => { '<' => $latest->plus_days(1) } }
        ]
    });
}

=head2 payees

Returns payees

=cut

sub payees {
    my $self = shift;
    $self->search({
        type => 'payee'
    });
}

1;
