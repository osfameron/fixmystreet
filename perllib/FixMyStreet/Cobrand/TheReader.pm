package FixMyStreet::Cobrand::TheReader;
use base 'FixMyStreet::Cobrand::UK';

use strict;
use warnings;

sub language_domain { 'FixMyStreet-TheReader' }

sub show_reports_with_map { 1 }
sub area_id { 2527 }

sub base_url {
    return FixMyStreet->config('BASE_URL') if FixMyStreet->config('STAGING_SITE');
    return 'http://thereader.org.uk';
}

sub path_to_web_templates {
    my $self = shift;
    return [
        FixMyStreet->path_to( 'templates/web', $self->moniker )->stringify,
        FixMyStreet->path_to( 'templates/web/fixmystreet' )->stringify
    ];
}

=head 2 pin_colour

Returns the colour of pin to be used for a particular report
(so perhaps different depending upon the age of the report).

=cut

sub pin_colour {
    my ( $self, $p, $context ) = @_;

    # TODO, this should be configurable

    my $category = $p->category || 'Other';
    return { 
        'Event'                  => 'book-red',
        'Favourite Reading Spot' => 'book-magenta',
        'Library Activity'       => 'book-blue',
        'Literary Facts'         => 'book-brown',
        'Reading Group'          => 'book-indigo',
        'School Activity'        => 'book-green',
        'Other'                  => 'book-grey',
    }->{$category} || 'book-grey';
}

sub pin_create_colour {
    return 'book-brown';
}

sub enter_postcode_text {
    my ($self) = @_;
    return 'Enter a Liverpool postcode, or street name and area';
}

sub disambiguate_location {
    my $self    = shift;
    my $string  = shift;
    return {
        %{ $self->SUPER::disambiguate_location() },
        town   => 'Liverpool',
        centre => '53.3954859587086,-2.91705385926665',
        span   => '0.163440332081315,0.201179283552342',
        bounds => [ 53.3115426747989, -3.01917947387853, 53.4749830068802, -2.81800019032618 ],
    };
}

sub example_places {
    return ( 'Whitechapel', 'Playhouse Theatre' );
}

# don't send questionnaires
sub send_questionnaires { return 0; }

# increase map zoom level so street names are visible
sub default_map_zoom { return 3; }

# let staff hide OCC reports
sub users_can_hide { return 1; }

sub default_show_name { 0 }

1;

