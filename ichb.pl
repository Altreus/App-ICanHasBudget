#!/usr/bin/env perl
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

get '/' => sub {
    my $c = shift;
    $c->render(
        template => 'index',
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
