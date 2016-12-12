$(document).ready(function() {
  var listing_address_attributes_address_line = $('#listing_address_attributes_address_line').get(0);

  if (listing_address_attributes_address_line) {
    var autocomplete = new google.maps.places.Autocomplete(listing_address_attributes_address_line, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    google.maps.event.addDomListener(listing_address_attributes_address_line, 'keydown', function(e) {
      if (e.keyCode == 13) {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  }
});

function onPlaceChanged() {
  var place = this.getPlace();
  var components = getAddressComponents(place);

  $('#listing_address_attributes_address_line').trigger('blur').val(components.address);
  $('#listing_address_attributes_zip_code').val(components.zip_code);
  $('#listing_address_attributes_city').val(components.city);
  if (components.country_code) {
    $('#listing_address_attributes_country').val(components.country_code);
  }
}

$(document).ready(function() {
  var listing_address_attributes_address_line = $('#address_address_line').get(0);

  if (address_address_line) {
    var autocomplete = new google.maps.places.Autocomplete(address_address_line, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChangedAddress);
    google.maps.event.addDomListener(address_address_line, 'keydown', function(e) {
      if (e.keyCode == 13) {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  }
});

function onPlaceChangedAddress() {
  var place = this.getPlace();
  var components = getAddressComponents(place);

  $('#address_address_line').trigger('blur').val(components.address);
  $('#address_zip_code').val(components.zip_code);
  $('#address_city').val(components.city);
  if (components.country_code) {
    $('#address_country').val(components.country_code);
  }
}

$(document).ready(function() {
  var user_address_attributes_address_line = $('#user_address_attributes_address_line').get(0);

  if (user_address_attributes_address_line) {
    var autocomplete = new google.maps.places.Autocomplete(user_address_attributes_address_line, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChangedUser);
    google.maps.event.addDomListener(user_address_attributes_address_line, 'keydown', function(e) {
      if (e.keyCode == 13) {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  }
});

function onPlaceChangedUser() {
  var place = this.getPlace();
  var components = getAddressComponents(place);

  $('#user_address_attributes_address_line').trigger('blur').val(components.address);
  $('#user_address_attributes_zip_code').val(components.zip_code);
  $('#user_address_attributes_city').val(components.city);
  if (components.country_code) {
    $('#user_address_attributes_country').val(components.country_code);
  }
}

$(document).ready(function() {
  var city = $('#city').get(0);

  if (city) {
    var autocomplete = new google.maps.places.Autocomplete(city, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    google.maps.event.addDomListener(city, 'keydown', function(e) {
      if (e.keyCode == 13) {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  }
});

function onPlaceChanged() {
  var place = this.getPlace();
  var components = getAddressComponents(place);

  $('#city').val(components.city);
}

function getAddressComponents(place) {
  // If you want lat/lng, you can look at:
  // - place.geometry.location.lat()
  // - place.geometry.location.lng()

  var street_number = null;
  var route = null;
  var zip_code = null;
  var city = null;
  var country_code = null;
  for (var i in place.address_components) {
    var component = place.address_components[i];
    for (var j in component.types) {
      var type = component.types[j];
      if (type == 'street_number') {
        street_number = component.long_name;
      } else if (type == 'route') {
        route = component.long_name;
      } else if (type == 'postal_code') {
        zip_code = component.long_name;
      } else if (type == 'locality') {
        city = component.long_name;
      } else if (type == 'country') {
        country_code = component.short_name;
      }
    }
  }

  return {
    address: street_number == null ? route : (street_number + ' ' + route),
    zip_code: zip_code,
    city: city,
    country_code: country_code
  };
}
