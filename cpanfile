requires 'perl', '>= 5.28.0';

requires 'Exporter::Tiny', '>= 1.002001';
requires 'Mojolicious',  '>= 8.20';

on 'test' => sub {
  requires 'Test2::Suite', '0.000122';
};

