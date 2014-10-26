use strict;
use warnings;
use HTML::Shakan;
use Test::More tests => 4;
use CGI;

diag "FVL: $FormValidator::Lite::VERSION";

# Copied from CGI.pm - http://search.cpan.org/perldoc?CGI
%ENV = (
    %ENV,
    'SCRIPT_NAME'       => '/test.cgi',
    'SERVER_NAME'       => 'perl.org',
    'HTTP_CONNECTION'   => 'TE, close',
    'REQUEST_METHOD'    => 'POST',
    'SCRIPT_URI'        => 'http://www.perl.org/test.cgi',
    'CONTENT_LENGTH'    => 3458,
    'SCRIPT_FILENAME'   => '/home/usr/test.cgi',
    'SERVER_SOFTWARE'   => 'Apache/1.3.27 (Unix) ',
    'HTTP_TE'           => 'deflate,gzip;q=0.3',
    'QUERY_STRING'      => '',
    'REMOTE_PORT'       => '1855',
    'HTTP_USER_AGENT'   => 'Mozilla/5.0 (compatible; Konqueror/2.1.1; X11)',
    'SERVER_PORT'       => '80',
    'REMOTE_ADDR'       => '127.0.0.1',
    'CONTENT_TYPE'      => 'multipart/form-data; boundary=xYzZY',
    'SERVER_PROTOCOL'   => 'HTTP/1.1',
    'PATH'              => '/usr/local/bin:/usr/bin:/bin',
    'REQUEST_URI'       => '/test.cgi',
    'GATEWAY_INTERFACE' => 'CGI/1.1',
    'SCRIPT_URL'        => '/test.cgi',
    'SERVER_ADDR'       => '127.0.0.1',
    'DOCUMENT_ROOT'     => '/home/develop',
    'HTTP_HOST'         => 'www.perl.org'
);

my $q = do {
    my $file = 't/dat/file_post.txt';
    local *STDIN;
    open STDIN, "<", $file or die "missing test file $file";
    binmode STDIN;
    CGI->new();
};

my $form = HTML::Shakan->new(
    request => $q,
    fields  => [
        FileField(
            name     => 'name',
            required => 1,
        ),
        FileField(
            name     => 'hello_world',
            required => 1,
        ),
        FileField(
            name     => 'unknown',
        ),
    ],
);
is $form->is_valid, 0, 'not valid';
is $form->is_error('name'), 1, 'not valid';
is $form->is_error('hello_world'), 0, 'valid';
is $form->is_error('unknown'), 0, 'valid';

