package App::ICanHasBudget::Controller::Trends;
use Mojo::Base qw/Mojolicious::Controller/;

sub index {
    my $self = shift;
    $self->render(
        template => 'trends',
        section => 'trends',
    );
};

1;
