#!/usr/bin/env perl
use Mojolicious::Lite;
use App::ICanHasBudget::Schema;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';
plugin 'Config';

helper schema => sub {
    my $c = shift;
    die "No dbic config key" unless $c->config->{dbic};

    state $s = App::ICanHasBudget::Schema->connect(
        $c->config->{dbic}->{dsn},
        $c->config->{dbic}->{user},
        $c->config->{dbic}->{pass},
        $c->config->{dbic}->{dbi_params}
    );
};

get '/' => sub {
    my $c = shift;
    $c->redirect_to('/kitties');
};

get '/kitties' => sub {
    my $c = shift;
    $c->render(
        template => 'kitties',
        section => 'kitties',
        kitties => [ $c->schema->resultset('Kitty')->all ],
    );
};

post '/kitties' => sub {
    my $c = shift;
    $c->schema->resultset('Kitty')->create({
        name => $c->param('new-kitty-name'),
        type => $c->param('new-kitty-type') ? 'target' : 'budget',
        parent_kitty_name => $c->param('parent-kitty') || undef
    });
    $c->redirect_to('/kitties');
};

get '/accounts' => sub {
    my $c = shift;
    $c->render(
        template => 'accounts',
        section => 'accounts'
    );
};

get '/trends' => sub {
    my $c = shift;
    $c->render(
        template => 'trends',
        section => 'trends',
    );
};

get '/add_transaction' => sub {
    my $c = shift;
    transaction_form($c)
};

sub transaction_form {
    my $c = shift;
    $c->render(
        template => 'transaction_form',
        section => 'accounts',
    );
}

app->start;
