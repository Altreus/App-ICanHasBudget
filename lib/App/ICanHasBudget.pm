package App::ICanHasBudget;
use strict;
use warnings;

use Mojo::Base qw/Mojolicious/;
use App::ICanHasBudget::Schema;

sub startup {
    my $self = shift;
    $self->plugin('Config' => { file => 'ichb.conf' });

    $self->helper(schema => sub {
        my $c = shift;
        die "No dbic config key" unless $c->config->{dbic};

        state $s = App::ICanHasBudget::Schema->connect(
            $c->config->{dbic}->{dsn},
            $c->config->{dbic}->{user},
            $c->config->{dbic}->{pass},
            $c->config->{dbic}->{dbi_params}
        );
    });

    my $r = $self->routes;
    $r->get('/')->to('root#index')->name('index');
    $r->get('/kitties')->to('kitties#index');
    $r->post('/kitties')->to('kitties#create');

    $r->get('/accounts')->to('accounts#index');

    $r->get('/trends')->to('trends#index');

    $r->get('/schedule')->to('schedule#index');
    $r->post('/schedule')->to('schedule#create');

    $r->get('/transaction/add')->to('transactions#form');

}

1;
