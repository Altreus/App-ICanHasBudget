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

=cut

primary_column name => {
    data_type => 'text',
};

# 'budget' or 'target'
column type => {
    data_type => 'text',
};

column capital => {
    data_type => 'int',
    default_value => 0,
};

column parent_kitty_name => {
    data_type => 'text',
    is_nullable => 1,
};

has_many transactions => 'App::ICanHasBudget::Schema::Result::Transaction' => 'kitty_name';
has_many sub_kitties => __PACKAGE__, 'parent_kitty_name';

sub balance {
    my $self = shift;
    $self->transactions->not_petty_cash->total // 0
}

sub used_percent {
    my $self = shift;

    return 0 unless $self->capital;

    return int($self->balance / $self->capital * 10) * 10;
}

sub recent_transactions {
    # TODO: decide what recent means
    my $self = shift;
    return $self->transactions;
}
1;
