#!/usr/bin/env perl
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

get '/' => sub {
    my $c = shift;
    $c->render(
        template => 'kitties',
        section => 'kitties'
    );
};

get '/accounts' => sub {
    my $c = shift;
    $c->render(
        template => 'accounts',
        section => 'accounts'
    );
};

app->start;
