package App::ICanHasBudget::Controller::Schedule;
use Mojo::Base qw/Mojolicious::Controller/;
use Time::Moment;

sub index {
    my $self = shift;

    my $calendar = [];
    my $today = Time::Moment->now;
    my $first_of_month = $today->with_day_of_month(1);
    my $next_month = $today->plus_months(1);
    my $first_of_week = $first_of_month->with_day_of_week(1);

    my $working_date = $first_of_week;
    while ($working_date->is_before($next_month)) {
        push @$calendar, [ map $working_date->with_day_of_week($_), 1..7 ];
        $working_date = $working_date->plus_days(7);
    }

    $self->render(
        template => 'schedule',
        section => 'schedule',
        calendar => $calendar,
        first_of_month => $first_of_month,
        last_of_month => $first_of_month->at_last_day_of_month,
        today => $today,
    );
}

1;
