use inc::Module::Install;
name 'Queue-Leaky';
all_from 'lib/Queue/Leaky.pm';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
