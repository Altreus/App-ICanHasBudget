package App::ICanHasBudget::Schema;

use base qw/DBIx::Class::Schema/;

our $VERSION="0.001";

__PACKAGE__->load_namespaces();

sub schema_version { 2 }

1;
