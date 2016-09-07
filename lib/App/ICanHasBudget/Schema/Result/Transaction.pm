package App::ICanHasBudget::Schema::Result::Transaction;
use DBIx::Class::Candy -autotable => v1;
our $VERSION="0.001";

=head1 NAME

App::ICanHasBudget::Schema::Result::Transaction - a transaction

=head1 DESCRIPTION

A Transaction represents a movement of money. It has an amount, in pence.

It may be associated with a Kitty, being the categorisation for this movement.

If it is not associated with a Kitty, it is of course uncategorised money.
Income will probably look like this. This also allows you to associate
transactions with special Accounts like Petty Cash without requiring the money
to be fully accounted for.

It will be associated with one or two Accounts. The C<from_account> is the
account the money left, and the C<to_account> is the one it entered.

If both accounts are the user's accounts, that's a straight-up transfer.

If one account is a payee, that's income or expense.

If both accounts are payees, that's a mistake.

=cut

primary_column id => {
    data_type => 'int',
    is_auto_increment => 1,
};

column amount => {
    data_type => 'int',
};

column kitty_name => {
    data_type => 'text',
    is_nullable => 1,
};

column from_account_name => {
    data_type => 'text',
    is_nullable => 1,
};

column to_account_name => {
    data_type => 'text',
    is_nullable => 0,
};

column date => {
    data_type => 'date',
    is_nullable => 1,
};

belongs_to kitty => 'App::ICanHasBudget::Schema::Result::Kitty' => 'kitty_name', { join_type => 'left' };
belongs_to from_account => 'App::ICanHasBudget::Schema::Result::Account' => 'from_account_name', { join_type => 'left' };
belongs_to to_account => 'App::ICanHasBudget::Schema::Result::Account' => 'to_account_name';

1;
