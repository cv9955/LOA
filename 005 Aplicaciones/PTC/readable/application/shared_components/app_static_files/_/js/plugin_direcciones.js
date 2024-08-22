var htmldb_ch_message='"OK_TO_GET_NEXT_PREV_PK_VALUE"';
var px;
var map;
var markers = [];
var loc1 = new Object();
var placeSearch, autocomplete;
var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initAutocomplete() {
   px ='P' + $v('pFlowStepId') + '_';
  // Create the autocomplete object, restricting the search to geographical location types.
  autocomplete = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById(px+'DIRECCION')),
      {types: ['geocode','establishment']});

  // When the user selects an address from the dropdown, populate the address fields in the form.
  autocomplete.addListener('place_changed', fillInAddress);

  // centra el mapa y agrega markers 

  var lat = document.getElementById(px+'LAT').value;
  var lng = document.getElementById(px+'LNG').value ;
  var loc = new google.maps.LatLng(lat , lng );

  map = new google.maps.Map(document.getElementById('map'), {
    center: loc,
    zoom: 15
  });

  deleteMarkers();
  map.setCenter(loc);
  addMarker(loc);


}

function fillInAddress() {
  // Get the place details from the autocomplete object.
 var place = autocomplete.getPlace();

  // limpia valores
  for (var component in componentForm) {
    var comp_id = px+component.toUpperCase();
    document.getElementById(comp_id).value = '';
    document.getElementById(comp_id).disabled = false;
  }

  // Get each component of the address from the place details
  // and fill the corresponding field on the form.
  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = place.address_components[i].types[0];
    var comp_id = px+addressType .toUpperCase();
    if (componentForm[addressType]) {
      var val = place.address_components[i][componentForm[addressType]];
      document.getElementById(comp_id).value = val;
    }
  }
  var lat = place.geometry.location.lat();
  var lng = place.geometry.location.lng();
  document.getElementById(px+'LAT').value = lat;
  document.getElementById(px+'LNG').value = lng;
  
  var loc = new Object();
  loc.lat = lat;
  loc.lng = lng;
  deleteMarkers();
  map.setCenter(loc);
  addMarker(loc);
  
}



// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}



// Adds a marker to the map and push to the array.
function addMarker(location) {
  var marker = new google.maps.Marker({
    position: location,
    map: map
  });
  markers.push(marker);
}

// Sets the map on all markers in the array.
function setMapOnAll(map) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
}

// Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
  setMapOnAll(null);
}
// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
  clearMarkers();
  markers = [];
}
