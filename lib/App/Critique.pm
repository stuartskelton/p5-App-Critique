package App::Critique;

use strict;
use warnings;

use File::HomeDir ();

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

our %CONFIG;

BEGIN {
    $App::Critique::CONFIG{'HOME'}    = $ENV{'CRITIQUE_HOME'}    || File::HomeDir->my_home;
    $App::Critique::CONFIG{'COLOR'}   = $ENV{'CRITIQUE_COLOR'}   || 0;
    $App::Critique::CONFIG{'DEBUG'}   = $ENV{'CRITIQUE_DEBUG'}   || 0;
    $App::Critique::CONFIG{'VERBOSE'} = $ENV{'CRITIQUE_VERBOSE'} || 0;
    $App::Critique::CONFIG{'EDITOR'}  = $ENV{'CRITIQUE_EDITOR'}  || $ENV{'EDITOR'} || $ENV{'VISUAL'};

    # okay, we give you sensible Perl & Git defaults
    $App::Critique::CONFIG{'IGNORE'} = {
        '.git'   => 1,
        'blib'   => 1,
        'local'  => 1,
        '_build' => 1,
    };

    # then we add in any of yours
    if ( my $ignore = $ENV{'CRITIQUE_IGNORE'} ) {
        $App::Critique::CONFIG{'IGNORE'}->{ $_ } = 1
            foreach split /\:/ => $ignore;
    }
}

use App::Cmd::Setup -app => {
    plugins => [
        'Prompt',
        '=App::Critique::Plugin::UI',
        '=App::Critique::Plugin::FileFilter'
    ]
};

1;

__END__

=pod

=cut
