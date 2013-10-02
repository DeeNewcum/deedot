# This is a higher-level system test.

    use Test::More tests => 2;
    use File::Temp qw( tempdir );
    use Cwd;
    use Data::Dumper;

    use strict;
    use warnings;

    sub DEBUG { 1 }

my $deedot = getcwd() . "/deedot";

my $orig_home = $ENV{HOME};
$ENV{HOME} = tempdir( CLEANUP => 1 );     # create  temporary home so that deedot doesn't overwrite the real ~/.bashrc
my $repoA = tempdir( CLEANUP => 1 );
my $repoB = tempdir( CLEANUP => 1 );

# confirm that deedot won't overwrite a symlink that its repository doesn't own
system 'touch', "$repoA/.bashrc";
symlink '/etc/profile', "$ENV{HOME}/.bashrc";
my $repoA_deedot = local_deedot($repoA);
my $deedot_output = qx[$repoA_deedot];
ok( $deedot_output =~ m#~/\.bashrc *already exists#,   "didn't overwrite symlink" );
ok( readlink("$ENV{HOME}/.bashrc") eq '/etc/profile',   "didn't overwrite symlink" );


if (DEBUG) {
    warn "\n======== temphome  $ENV{HOME} ========\n" . qx[ls -lA --color=always $ENV{HOME}];
    warn "\n======== repoA ========\n" . qx[ls -lA --color=always $repoA];
    warn "\n======== repoB ========\n" . qx[ls -lA --color=always $repoB];
    warn "\n";
}


# run deedot from a specific directory
sub local_deedot {
    my ($repo_dir) = @_;
    my $repo_deedot = "$repo_dir/deedot";
    if (! -l $repo_deedot) {
        # deedot has to be physically present in a directory to run it from there
        system "cp", $deedot, $repo_deedot;
    }
    return $repo_deedot;
}
