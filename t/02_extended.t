use strict;
use Test::More tests => 18;
use Queue::Leaky;

{
    my $table = "q_incoming";
    my $queue = Queue::Leaky->new(
        queue => {
            module => 'Q4M',
            connect_info => [
                $ENV{QLEAKY_Q4M_DSN},
                $ENV{QLEAKY_Q4M_USERNAME},
                $ENV{QLEAKY_Q4M_PASSWORD},
                { RaiseError => 1, AutoCommit => 1 },
            ],
        },
    );

    ok( $queue, "queue ok" );
    isa_ok( $queue, "Queue::Leaky", "queue class ok" );

    my $message = {
        destination => "world",
        message     => "Hello!",
    };

    ok( $queue->insert($table, $message) );
    my $rv = $queue->next($table);
    is( $rv, $table );
    is( $queue->fetch($rv)->{message}, "Hello!" );
    ok( $queue->clear($table) );
}

{
    my $max = 3;
    my $queue = Queue::Leaky->new(
        max_items => $max,
        state => {
            module => 'Memcached',
            memcached => {
                servers => [ qw(127.0.0.1:11211) ],
            }
        },
    );

    for my $count (1 .. $max) {
        ok( $queue->insert($count) );
    }
    ok( !$queue->insert("I'm not there") );

    for my $count (1 .. $max) {
        ok( $queue->next );
        is( $queue->fetch, $count );
    }
    ok( !$queue->next );

    is( $queue->state_get($queue->queue), 0 );
}
