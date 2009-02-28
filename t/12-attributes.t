#!perl 

use Test::More qw(no_plan);
use Tree::Family;
use Tree::Family::Person;
use strict;
our $tmpfile = "/tmp/treefile.3$$";
our $tmpdot = "/tmp/dotfile.3$$";

$Tree::Family::Person::keyMethod = 'first_name';

#
#         abe --- berma   
#              |     
#    carl -- darlene
#
diag "Making temporary file $tmpfile";
{
    my $tree = Tree::Family->new(filename => $tmpfile);
    my $a = Tree::Family::Person->new(first_name => 'abe', last_name => 'lincoln', gender => 'm');
    $tree->add_person($a);
    $tree->write;
}

%Tree::Family::Person::globalHash = ();

{
    my $tree = Tree::Family->new(filename => $tmpfile);
    my $a = $tree->find(first_name => 'abe');
    ok defined($a), 'found abe';
    cmp_ok $a->gender, 'eq', 'm', 'gender';
    cmp_ok $a->last_name, 'eq', 'lincoln', 'last name';
}
    



