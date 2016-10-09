package App::ICanHasBudget::Controller::Kitties;
use Mojo::Base qw/Mojolicious::Controller/;

sub index {
    my $self = shift;
    $self->render(
        template => 'kitties',
        section => 'kitties',
        kitties => [ $self->schema->resultset('Kitty')->all ],
    );
};

sub create {
    my $self = shift;
    $self->schema->resultset('Kitty')->create({
        name => $self->param('new-kitty-name'),
        type => $self->param('new-kitty-type'),
        capital => $self->param('new-kitty-capital'),
        parent_kitty_name => $self->param('parent-kitty') || undef
    });
    $self->redirect_to('/kitties');
};


1;
