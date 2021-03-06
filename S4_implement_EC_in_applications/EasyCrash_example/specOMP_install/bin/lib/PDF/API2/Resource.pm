#=======================================================================
#    ____  ____  _____              _    ____ ___   ____
#   |  _ \|  _ \|  ___|  _   _     / \  |  _ \_ _| |___ \
#   | |_) | | | | |_    (_) (_)   / _ \ | |_) | |    __) |
#   |  __/| |_| |  _|    _   _   / ___ \|  __/| |   / __/
#   |_|   |____/|_|     (_) (_) /_/   \_\_|  |___| |_____|
#
#   A Perl Module Chain to faciliate the Creation and Modification
#   of High-Quality "Portable Document Format (PDF)" Files.
#
#   Copyright 1999-2005 Alfred Reibenschuh <areibens@cpan.org>.
#
#=======================================================================
#
#   This library is free software; you can redistribute it and/or
#   modify it under the terms of the GNU Lesser General Public
#   License as published by the Free Software Foundation; either
#   version 2 of the License, or (at your option) any later version.
#
#   This library is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public
#   License along with this library; if not, write to the
#   Free Software Foundation, Inc., 59 Temple Place - Suite 330,
#   Boston, MA 02111-1307, USA.
#
#   $Id: Resource.pm,v 2.0 2005/11/16 02:16:00 areibens Exp $
#
#=======================================================================

package PDF::API2::Resource;

BEGIN {

    use PDF::API2::Util;
    use PDF::API2::Basic::PDF::Utils;
    use PDF::API2::Basic::PDF::Dict;
    use POSIX;

    use vars qw(@ISA $VERSION);

    @ISA = qw( PDF::API2::Basic::PDF::Dict );

    ( $VERSION ) = sprintf '%i.%03i', split(/\./,('$Revision: 2.0 $' =~ /Revision: (\S+)\s/)[0]); # $Date: 2005/11/16 02:16:00 $

}

no warnings qw[ deprecated recursion uninitialized ];

=head1 $res = PDF::API2::Resource->new $pdf, $name

Returns a resource object.

=cut

sub new {
    my ($class,$pdf,$name) = @_;
    my $self;

    $class = ref $class if ref $class;

    $self=$class->SUPER::new();
    $pdf->new_obj($self) unless($self->is_obj($pdf));

    $self->name($name || pdfkey());

    $self->{' apipdf'}=$pdf;

    return($self);
}

=item $res = PDF::API2::Resource->new_api $api, $name

Returns a resource object. This method is different from 'new' that
it needs an PDF::API2-object rather than a Text::PDF::File-object.

=cut

sub new_api {
    my ($class,$api,@opts)=@_;

    my $obj=$class->new($api->{pdf},@opts);
    $obj->{' api'}=$api;

    return($obj);
}

=item $name = $res->name $name

Returns or sets the Name of the resource.

=cut

sub name {
    my $self=shift @_;
    if(scalar @_ >0 && defined($_[0])) {
        $self->{Name}=PDFName($_[0]);
    }
    return($self->{Name}->val);
}

sub outobjdeep {
    my ($self, $fh, $pdf, %opts) = @_;

    return $self->SUPER::outobjdeep($fh, $pdf) if defined $opts{'passthru'};
    foreach my $k (qw/ api apipdf /) {
        $self->{" $k"}=undef;
        delete($self->{" $k"});
    }
    $self->SUPER::outobjdeep($fh, $pdf, %opts);
}

1;

__END__

=head1 AUTHOR

alfred reibenschuh

=head1 HISTORY

    $Log: Resource.pm,v $
    Revision 2.0  2005/11/16 02:16:00  areibens
    revision workaround for SF cvs import not to screw up CPAN

    Revision 1.2  2005/11/16 01:27:48  areibens
    genesis2

    Revision 1.1  2005/11/16 01:19:24  areibens
    genesis

    Revision 1.10  2005/06/17 19:43:47  fredo
    fixed CPAN modulefile versioning (again)

    Revision 1.9  2005/06/17 18:53:33  fredo
    fixed CPAN modulefile versioning (dislikes cvs)

    Revision 1.8  2005/03/14 22:01:05  fredo
    upd 2005

    Revision 1.7  2004/12/16 00:30:52  fredo
    added no warn for recursion

    Revision 1.6  2004/06/15 09:11:38  fredo
    removed cr+lf

    Revision 1.5  2004/06/07 19:44:12  fredo
    cleaned out cr+lf for lf

    Revision 1.4  2003/12/08 13:05:19  Administrator
    corrected to proper licencing statement

    Revision 1.3  2003/11/30 17:18:38  Administrator
    merged into default

    Revision 1.2.2.1  2003/11/30 16:56:22  Administrator
    merged into default

    Revision 1.2  2003/11/29 23:31:21  Administrator
    added CVS id/log


=cut
