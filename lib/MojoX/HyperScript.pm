package MojoX::HyperScript;

use strict;
use warnings;

use Exporter::Shiny our @EXPORT = qw[ H ];
use Carp qw[ cluck ];

our $VERSION = "0.01";

use Mojo::DOM;

sub _parse_tags {
  my $src = shift;

  my ( $name, $attr ) = ( $src =~ m{^([^#\.\s]+)(.+)?$} );
  my ( $id, @classes ) = ( q{}, () );

  while ( defined($attr) && $attr ne q{} && $attr =~ m{^([#\.])([^#\.\s]+)} ) {
    my ( $sym, $val ) = ( $1, $2 );

    if ( $sym eq '#' ) {
      $id = $val;
    }
    elsif ( $sym eq '.' ) {
      push @classes, $val;
    }

    $attr = substr $attr, length($sym . $val);
  } 

  return ($name, $id, @classes);
}

sub H ($;@) {
  my ( $tag, @contents ) = @_;
  my ( $name, $id, @classes ) = _parse_tags($tag);

  my $elm = Mojo::DOM->new_tag($name)->at($name);
  if ( $id ne q{} ) {
    $elm->attr( id => $id );
  }

  if ( scalar(@classes) != 0 ) {
    $elm->attr( class => join (q{ }, @classes) );
  }
  
  for my $content ( @contents ) {
    my $type = ref $content;
    
    if ( $type eq 'Mojo::DOM::HTML' ) {
      $elm->append($content);
      next;
    }
    elsif ( $type eq 'ARRAY' ) {
      for my $nest ( $content->@* ) {
        if ( ref $nest eq 'Mojo::DOM::HTML' ) {
          $elm->append($nest);
        } else {
          $elm->append_content("${nest}");
        }
      }
      next;
    }
    elsif ( $type eq 'HASH' ) {
      $elm->attr($content);
      next;
    }

    $elm->append_content("${content}");
  }

  return $elm;
}


1;
__END__

=encoding utf-8

=head1 NAME

MojoX::HyperScript - A hyperscript-like thin wrapper for L<Mojo::DOM>

=head1 SYNOPSIS

    use MojoX::HyperScript qw[ H ];
    
    # <p>hello, world!</p>
    my $dom = H 'p' => 'hello, world!';

    # <p class="msg">this is an message.</p>
    my $dom = H 'p.msg' => 'this is an message.';
    
    # <p id="important">this is an important message!</p>
    my $dom = H 'p#important' => 'this is an important message!';
    
    # <p id="msg" class="warn">warnings!</p>
    my $dom = H 'p#msg.warn' => 'warnings!';
    
    # <p id="msg" class="info" data-to="nyarla">info to nyarla</p>
    my $dom = H 'p#msg.info' => { data => { to => 'nyarla' } }, 'info to nyarla';
    
    # <p>hi, <em>nyarla</em></p>
    my $dom = H 'p' => [ 'hi, ', H( em => 'nyarla' ) ];

=head1 DESCRIPTION

MojoX::HyperScript is a hyperscript-like thin wrapper for L<Mojo::DOM>. 

This module is made for writing html as Perl code,
and alternative of text-based template engines.

=head1 FUNCTIONS

=head2 C<H($;@)>

    my $tag       = 'p#msg.warn.info';
    my $attr      = { data => { to => 'nyarla' } };
    my $contents  = [ 'hi' ];

    my @describes = ( $attr, $contents, 'this is an message'); 
    
    my $dom = H $tag, @contents;

This function makes L<Mojo::DOM> object from these arguments as follow:

=over

=item C<$tag>: Str (required)

This argument is specified to tag name for element.

C<$tag> can includes C<#id> as element id, and C<.className> as element classes.

For example, C<$tag> string is C<p#msg.warn.info>, this C<p> is sets to element tag name,
this C<msg> is sets to element id, and C<warn> or C<info> are sets to element classes.

=item ( C<$attr>: HashRef | C<$contents>: ArrayRef | C<text>: Str ): List (optional)

These arguments are describes to element attributes and contents.

For example, C<$attr> as C<HashRef> is passed to L<Mojo::DOM>'s C<attr> method,
C<$content> as L<ArrayRef> is adds content of that argument as child nodes,
and C<text> as L<Str> is appends text node to element.

=back

=head1 LICENSE

Copyright (C) nyarla.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

OKAMURA Naoki a.k.a nyarla E<lt>nyarla@kalaclista.comE<gt>

=head1 SEE ALSO

L<Mojo::DOM> is based for makes DOM tree on perl.

L<Exporter::Tiny> is used for exports C<H> function.

L<https://github.com/hyperhype/hyperscript> is original idea of this module.

=cut

