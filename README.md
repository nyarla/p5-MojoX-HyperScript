# NAME

MojoX::HyperScript - A hyperscript-like thin wrapper for [Mojo::DOM](https://metacpan.org/pod/Mojo::DOM)

# SYNOPSIS

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

# DESCRIPTION

MojoX::HyperScript is a hyperscript-like thin wrapper for [Mojo::DOM](https://metacpan.org/pod/Mojo::DOM). 

This module is made for writing html as Perl code,
and alternative of text-based template engines.

# FUNCTIONS

## `H($;@)`

    my $tag       = 'p#msg.warn.info';
    my $attr      = { data => { to => 'nyarla' } };
    my $contents  = [ 'hi' ];

    my @describes = ( $attr, $contents, 'this is an message'); 
    
    my $dom = H $tag, @contents;

This function makes [Mojo::DOM](https://metacpan.org/pod/Mojo::DOM) object from these arguments as follow:

- `$tag`: Str (required)

    This argument is specified to tag name for element.

    `$tag` can includes `#id` as element id, and `.className` as element classes.

    For example, `$tag` string is `p#msg.warn.info`, this `p` is sets to element tag name,
    this `msg` is sets to element id, and `warn` or `info` are sets to element classes.

- ( `$attr`: HashRef | `$contents`: ArrayRef | `text`: Str ): List (optional)

    These arguments are describes to element attributes and contents.

    For example, `$attr` as `HashRef` is passed to [Mojo::DOM](https://metacpan.org/pod/Mojo::DOM)'s `attr` method,
    `$content` as [ArrayRef](https://metacpan.org/pod/ArrayRef) is adds content of that argument as child nodes,
    and `text` as [Str](https://metacpan.org/pod/Str) is appends text node to element.

# LICENSE

Copyright (C) nyarla.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

OKAMURA Naoki a.k.a nyarla <nyarla@kalaclista.com>

# SEE ALSO

[Mojo::DOM](https://metacpan.org/pod/Mojo::DOM) is based for makes DOM tree on perl.

[Exporter::Tiny](https://metacpan.org/pod/Exporter::Tiny) is used for exports `H` function.

[https://github.com/hyperhype/hyperscript](https://github.com/hyperhype/hyperscript) is original idea of this module.
