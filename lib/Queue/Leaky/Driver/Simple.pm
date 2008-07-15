package Queue::Leaky::Driver::Simple;

use Moose;
use Queue::Base;

with 'Queue::Leaky::Driver';

has 'base' => (
    is       => 'rw',
    isa      => 'Queue::Base',
    default  => sub { Queue::Base->new },
    required => 1,
);

__PACKAGE__->meta->make_immutable;

no Moose;

sub next { }

sub fetch { }

sub insert { }

sub clear { }

1;

__END__

=head1 NAME 

Queue::Leaky::Driver::Simple - Queue::Base Implementation

=head1 SYNOPSIS

  use Queue::Leaky::Driver::Simple;

  my $queue = Queue::Leaky::Driver::Simple->new;

  $queue->next;

  $queue->fetch;

  $queue->insert( ... );

  $queue->clear;

=head1 METHODS

=head2 next

=head2 fetch

=head2 insert

=head2 clear

=cut
