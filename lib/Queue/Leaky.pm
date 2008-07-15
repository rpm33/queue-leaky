package Queue::Leaky;

use Moose;
use Queue::Leaky::Types;

our $VERSION = '0.01';

{
    my $default = sub {
        my $class = shift;
        return sub {
            Class::MOP::load_class($class);
            $class->new;
        };
    };

    has 'queue' => (
        is       => 'rw',
        does     => 'Queue::Leaky::Driver',
        required => 1,
        coerce   => 1,
        default  => $default->( 'Queue::Leaky::Driver::Simple' ),
        handles  => {
            map { ( "q_$_" => $_ ) }
                qw(next fetch insert clear)
        },
    );

    has 'state' => (
        is       => 'rw',
        does     => 'Queue::Leaky::State',
        required => 1,
        coerce   => 1,
        default  => $default->( 'Queue::Leaky::State::Memory' ),
        handles  => {
            map { ("state_$_" => $_) } qw(get set remove incr decr)
        }
    );
}

__PACKAGE__->meta->make_immutable;

no Moose;

sub next { }

sub fetch { }

sub insert { }

sub clear { }

1;

__END__

=encoding utf-8

=for stopwords

=head1 NAME

Queue::Leaky - Queues with leaky buckets

=head1 SYNOPSIS

  use Queue::Leaky;
  my $queue = Queue::Leaky->new;

  $queue->inesrt( ... );

  while ( 1 ) {
    if ($queue->next) {
      my $message = $queue->fetch;
    }
  }

  $queue->clear;

=head1 DESCRIPTION

Queue::Leaky is employed as a traffic regulator.

=head1 AUTHOR

Taro Funaki E<lt>t@33rpm.jpE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
