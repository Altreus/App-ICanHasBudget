package App::ICanHasBudget::Schema::Result::ScheduledTransaction;
use v5.14;
use DBIx::Class::Candy
    -autotable => v1,
    -components => [ 'InflateColumn::TimeMoment' ]
;

use DateTime::Duration;
our $VERSION="0.001";

=head1 NAME

App::ICanHasBudget::Schema::Result::ScheduledTransaction - Regular transactions

=head1 DESCRIPTION

A scheduled transaction will be shown on the schedule and automatically created
as default budget in a kitty when the month starts.

=head1 PROPERTIES

=head2 id

Since this resource has no natural identifier we use an auto-incrementing
primary key.

=cut

primary_column id => {
    data_type => 'int',
    is_auto_increment => 1,
};

=head2 description

A description of the transaction.

=cut

column description => {
    data_type => 'text',
};

=head2 amount

Value, in (currently) pence, of the transaction

=cut

column amount => {
    data_type => 'int',
};

=head2 next_occurrence

Date of the next occurrence. Previous occurrences can be found by interrogating
the L<App::ICanHasBudget::Schema::Result::Transaction|Transactions> table for
ones produced by this schedule.

TODO: link generated transactions back

=cut

column next_occurrence => {
    data_type => 'date',
};

=head2 end_date

If defined, the last date of relevance. Dates after this will not be returned.
This date may be returned if it falls on an occurence.

=cut

column end_date => {
    data_type => 'date',
    is_nullable => 1,
};

=head2 schedule

A string defining the repetition of the transaction, being a type and a number.

The format is basically just a mini hash for L<DateTime::Duration/new>,
concatenated by space, e.g. C<weeks 2>.  The date of the last occurrence is
used.

Transactions do not have to be recurring.

=cut

column schedule => {
    data_type => 'text',
    is_nullable => 1,
};

##TODO
#has_many history => 'App::ICanHasBudget::Schema::Result::Transaction' => 'schedule_id';

=head1 METHODS

=head2 iterator

Returns an iterator object that generates DateTime objects for successive
occurrences.

=cut

sub iterator {
    my $self = shift;
    state $it = App::ICanHasBudget::Schema::Result::ScheduledTransaction::Iterator->new(
        subref => sub {
            state $last;
            if (! $last) {
                $last = $self->next_occurrence;
                return $last;
            }
            else {
                $last->add_duration( $self->schedule_as_duration );
            }
        }
    );
}

=head2 schedule_as_duration

Returns a L<DateTime::Duration> defined by the L</schedule>.

=cut

sub schedule_as_duration {
    my $self = shift;
    return DateTime::Duration->new( split ' ', $self->schedule );
}

package App::ICanHasBudget::Schema::Result::ScheduledTransaction::Iterator;

use Mojo::Base -base;
has subref => ( is => 'ro' );
sub next { shift->subref->() }

1;
