package App::ICanHasBudget::Schema::Result::Account;
use DBIx::Class::Candy -autotable => v1;
our $VERSION="0.001";

=head1 NAME

App::ICanHasBudget::Schema::Result::Account - A money-holding account

=head1 DESCRIPTION

Transactions are made against Accounts.

Transactions in Accounts contribute to the budget; the total amount in all
Accounts should be the amount of money you have.

A payee Account is an external source or destination. There'll be a lot of
those.

All the others are "user" accounts; i.e. they are controlled by the user.

=cut

primary_column name => {
    data_type => 'text',
};

# bank, savings, cash, petty cash, credit, payee
column type => {
    data_type => 'text',
};

has_many transactions_in => 'App::ICanHasBudget::Schema::Result::Transaction' => 'to_account_name';
has_many transactions_out => 'App::ICanHasBudget::Schema::Result::Transaction' => 'from_account_name';

sub balance {
    return $_[0]->transactions_in->total - $_[0]->transactions_out->total
}

our %types_words = (
    bank => 'Bank Account',
    savings => 'Savings',
    cash => 'Cash',
    'petty cash' => 'Petty Cash',
    credit => 'Credit Card',
    payee => 'Payee'
);

sub type_words {
    my $self = shift;

    return $types_words{$self->type};
}
1;
