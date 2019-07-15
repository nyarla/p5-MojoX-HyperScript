# vim: ft=perl

requires 'perl', '>= 5.28.0';

requires 'Exporter::Tiny', '>= 1.002001';
requires 'Mojolicious',  '>= 8.20';

on 'develop' => sub {
  requires 'CPAN::Uploader', '>= 0.103013';
  requires 'Version::Next', '>= 1.000';
  requires 'Software::License', '>= 0.103014';
};

on 'test' => sub {
  requires 'Test2::Suite', '>= 0.000122';
};

