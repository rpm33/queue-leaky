package Queue::Leaky;

use Moose;
our $VERSION = '0.01';

__PACKAGE__->meta->make_immutable;

no Moose;

1;

__END__

=encoding utf-8

=for stopwords

=head1 NAME

Queue::Leaky - Queues with leaky buckets

=head1 SYNOPSIS

  use Queue::Leaky;
  my $queue = Queue::Leaky->new;

=head1 DESCRIPTION

Queue::Leaky is employed as a traffic regulator.

=head1 AUTHOR

Taro Funaki E<lt>t@33rpm.jpE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
