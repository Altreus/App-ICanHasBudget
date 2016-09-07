package App::ICanHasBudget::Schema::ResultSet::Transaction;

use strict;
use warnings;
use base qw/DBIx::Class::ResultSet/;

=head1 NAME

App::ICanHasBudget::Schema::ResultSet::Transaction - Transaction methods

=head1 DESCRIPTION

It's a ResultSet for Transactions. You know how this works.

=head1 METHODS

=head2 total

Sums the amount column; thus, returns pence.

=cut

sub total {
    my $self = shift;
    $self->get_column('amount')->sum;
}

=head2 not_petty_cash

Filter out transactions that came from petty cash accounts.

=cut

sub not_petty_cash {
    my $self = shift;
    $self->search({
            'from_account.type' => {
                '!=' => 'petty cash'
            }
        },
        {
            join => 'from_account'
        }
    )
}

1;
