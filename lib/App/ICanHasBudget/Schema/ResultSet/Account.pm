package App::ICanHasBudget::Schema::ResultSet::Account;

use strict;
use warnings;
use base qw/DBIx::Class::ResultSet/;

=head1 NAME

App::ICanHasBudget::Schema::ResultSet::Account - Account methods

=head1 DESCRIPTION

ResultSet for Accounts.

=head1 METHODS

=head2 user

Returns user accounts

=cut

sub user {
    my $self = shift;
    $self->search({
        type => {
            '!=' => 'payee'
        }
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
