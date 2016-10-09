package App::ICanHasBudget::Controller::Root;
use Mojo::Base qw/Mojolicious::Controller/;

sub index {
    my $self = shift;
    $self->redirect_to('/kitties');
};

1;
