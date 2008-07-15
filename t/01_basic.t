use strict;
use Test::More tests => 6;
use Queue::Leaky;

TODO: {
    local $TODO = "there is a skeleton code only";

    my $queue = Queue::Leaky->new;

    ok( $queue, "queue ok" );
    isa_ok( $queue, "Queue::Leaky", "queue class ok" );

    my $message = "Hello!";

    ok( $queue->insert($message) );
    ok( $queue->next );
    is( $queue->fetch, "Hello!" );
    ok( $queue->clear );
}
