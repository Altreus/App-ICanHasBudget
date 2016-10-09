package App::ICanHasBudget::Controller::Transactions;
use Mojo::Base qw/Mojolicious::Controller/;

sub form {
    my $self = shift;
    $self->render(
        template => 'transaction_form',
        section => 'accounts',
    );
}

1;
