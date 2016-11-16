package App::ICanHasBudget::Controller::Schedule;
use Mojo::Base qw/Mojolicious::Controller/;
use Time::Moment;
use 5.014;

sub index {
    my $self = shift;

    my $calendar = [];
    my $today = Time::Moment->now;
    my $first_of_month = $today->with_day_of_month(1);
    my $next_month = $first_of_month->plus_months(1);
    my $first_of_week = $first_of_month->with_day_of_week(1);

    my $working_date = $first_of_week;
    while ($working_date->is_before($next_month)) {
        push @$calendar, [ map $working_date->with_day_of_week($_), 1..7 ];
        $working_date = $working_date->plus_days(7);
    }

    my $events = $self->schema->resultset('ScheduledTransaction')
        ->between($calendar->[0][0], $calendar->[-1][-1]);

    $self->render(
        template => 'schedule',
        section => 'schedule',
        calendar => $calendar,
        events => $events,
        first_of_month => $first_of_month,
        last_of_month => $first_of_month->at_last_day_of_month,
        today => $today,
    );
}

sub create {
    my $self = shift;

    $self->schema->resultset('ScheduledTransaction')
        ->create({
            description => $self->param('transaction-description'),
            amount => $self->param('transaction-amount') * 10,
            next_occurrence => $self->param('transaction-date'),
            $self->param('recurs')
                ? ( schedule => join ' ', $self->param('transaction-frequency'), $self->param('transaction-period') )
                : ()
        });

    $self->redirect_to('/schedule');
}

1;
