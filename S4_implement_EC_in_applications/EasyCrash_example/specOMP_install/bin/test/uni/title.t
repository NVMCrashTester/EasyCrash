BEGIN {
  use TestInit;
#    chdir 't' if -d 't';
#    @INC = qw(../lib uni .);
  push @INC, 'uni';
    require "case.pl";
}

casetest("Title", \%utf8::ToSpecTitle, sub { ucfirst $_[0] },
	 sub { my $a = ""; ucfirst ($_[0] . $a) });
