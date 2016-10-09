package App::ICanHasBudget::Controller::Accounts;
use Mojo::Base qw/Mojolicious::Controller/;

sub index {
    my $self = shift;
    $self->render(
        template => 'accounts',
        section => 'accounts',
        accounts => [ $self->schema->resultset('Account')->user->all ],
        payees => [ $self->schema->resultset('Account')->payees->all ],
    );
};

1;
