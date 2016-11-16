package App::ICanHasBudget::Schema::Result::Kitty;
use DBIx::Class::Candy -autotable => v1;
our $VERSION="0.001";

=head1 NAME

App::ICanHasBudget::Schema::Result::Kitty - A container for budgets

=head1 DESCRIPTION

A kitty is a place where money is assigned. It can either be a budget or a
target.

Kitties have transactions associated with them. A transaction leaving our
accounts will decrement from the kitty. A transaction with only the from
account will add to the kitty (by assigning money from that account to the
kitty).

There is always a "petty cash" kitty. Transfers into the petty cash kitty are
sunk.

=head1 PROPERTIES

=head2 name

This is the primary identifier for this resource. Name is an arbitrary string.

=cut

primary_column name => {
    data_type => 'text',
};

=head2 type

One of 'budget' or 'target',

=cut

# 'budget' or 'target'
column type => {
    data_type => 'text',
};

=head2 capital

The amount of money in this kitty, in the lowest denominator of this currency.
Which we don't have - GBP is the only supported currency right now.

=cut

column capital => {
    data_type => 'int',
    default_value => 0,
};

=head2 parent_kitty_name

The name of the parent kitty, or C<undef> if it has none.

=cut

column parent_kitty_name => {
    data_type => 'text',
    is_nullable => 1,
};

=head2 transactions

ResultSet of L<App::ICanHasBudget::Schema::Result::Transaction>s.

=cut

has_many transactions => 'App::ICanHasBudget::Schema::Result::Transaction' => 'kitty_name';

=head2 sub_kitties

ResultSet of L<App::ICanHasBudget::Schema::Result::Kitty> objects, linked by
L</parent_kitty_name>.

=cut

has_many sub_kitties => __PACKAGE__, 'parent_kitty_name';

=head1 METHODS

=head2 balance

Amount of money left in this kitty, being the sum of all transactions not
assigned to a petty cash account.

See also L<App::ICanHasBudget::Schema::ResultSet::Transaction>.

=cut

sub balance {
    my $self = shift;
    $self->transactions->not_petty_cash->total // 0
}

=head2 used_percent

The balance of the kitty as a percentage of the assigned capital, subtracted
from 100.

=cut

sub used_percent {
    my $self = shift;

    return 0 unless $self->capital;

    return 100 - int($self->balance / $self->capital * 10) * 10;
}

=head2 recent_transactions

A ResultSet of L<App::ICanHasBudget::Schema::Result::Transaction>s, based on
some arbitrary criteria for recency I've not chosen yet.

=cut

sub recent_transactions {
    # TODO: decide what recent means
    my $self = shift;
    return $self->transactions;
}
1;
