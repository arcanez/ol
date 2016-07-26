use strict;
use warnings;
use Text::CSV;
use DBI;

our $VERSION = '0.0001';

my $file = 'engineering_project_businesses';

my $dbh = DBI->connect("dbi:SQLite:dbname=${file}.db", '', '');

$dbh->do("DROP TABLE IF EXISTS businesses");
$dbh->do("CREATE TABLE IF NOT EXISTS businesses (id INTEGER PRIMARY KEY ASC, uuid TEXT, name TEXT, address TEXT, address2 TEXT, city TEXT, state TEXT, zip TEXT, country TEXT, phone TEXT, website TEXT, created_at TEXT);");

my $csv = Text::CSV->new({ binary => 1 });

open my $fh, '<:encoding(utf8)', $file . '.csv';
my $header = $csv->getline($fh);
my @headers = ();
my @placeholders = ();
push @headers, $header->[$_] for (0..$#$header);
push @placeholders, '?' for (0..$#$header);

my $sql = "INSERT INTO businesses (" . (join ', ', @headers) . ") VALUES (" . (join ',', @placeholders) . ');';
my $sth = $dbh->prepare($sql);

my $count = 0;
while (my $row = $csv->getline($fh)) {
  my @values = ();
  push @values, $row->[$_] for (0..$#$row);
  $sth->execute(@values);
  print "Inserted $count records\n" unless ++$count % 1000;
}
