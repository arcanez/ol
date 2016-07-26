use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'OwnLocal Coding Test',
  AUTHOR => 'Justin Hunter <justin.d.hunter@gmail.com>',
  VERSION_FROM => 'csv2sqlite.pl',
  LICENSE => 'perl',
  MIN_PERL_VERSION => '5.008001',
  PREREQ_PM => {
    'Text::CSV' => '0',
    'DBD::sqlite' => '0',
  },
  BUILD_REQUIRES => {
  },
  META_MERGE => {
  }
);
