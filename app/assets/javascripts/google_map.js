
var boundsForLocations = function(locations){
  var bounds = {  n: locations[0].lat,
                  e: locations[0].lng,
                  s: locations[0].lat,
                  w: locations[0].lng
                };

  for (var i=0; i < locations.length; i++) {
    if (bounds.n < locations[i].lat) {
      bounds.n = locations[i].lat;
    }
    if (bounds.s > locations[i].lat) {
      bounds.s = locations[i].lat;
    }
    if (bounds.e > locations[i].lng) {
      bounds.e = locations[i].lng;
    }
    if (bounds.w < locations[i].lng) {
      bounds.w = locations[i].lng;
    }
    // console.log(locations[i].lat, locations[i].lng)
  }

  var ne = new google.maps.LatLng(bounds.n, bounds.e);
  var sw = new google.maps.LatLng(bounds.s, bounds.w);

  return new google.maps.LatLngBounds(ne, sw);
}

// ----------- GOOGLE PLACES API

var placeSearch = function(event) {
  console.log(event);
  $.ajax({
    url: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=" + ENV["GOOGLE_PLACES_API_KEY"] + "&keyword=pizza&location=40.751402%2C-73.9898218&radius=2000&sensor=false&type=restaurant",
    type: "GET",
    success: function(e) {
      alert("it worked?");
      console.log(e);
    }

  });

}

// ----------- GOOGLE MAPS API

var getCurrentLocation = function() {
  var setGeoCookie = function(geoPosition) {
    //console.log(geoPosition, geoPosition.coords)
    var coords = geoPosition.coords;
    var cookie = coords.latitude + "|" + coords.longitude;
    console.log("GOT POSITION / SETTING COOKIE...")

    document.cookie = "location=" + escape(cookie);
  }

  console.log("GETTING POSITION...")
  navigator.geolocation.getCurrentPosition(setGeoCookie);
}

var getLocation = function(locations, mainLocation, myCallback) {
  var location_callback = function(geoPosition) {
    //console.log(geoPosition, geoPosition.coords)
    var coords = geoPosition.coords;
    var lat = locations[0].lat || coords.latitude;
    var lng = locations[0].lng || coords.longitude;

    var mapArray = loadGoogleMaps(lat, lng, locations, mainLocation);

    //loc = { lat: 40.7308361, lng: -73.9922004 }
    //locLit = "" + 40.7308361 + "," + -73.9922004;
    //placeMarker(loc, map);
    // for (var i=0; i < loc.length; i++) {
    //   placeMarker(loc[i], map);
    // }


    myCallback(mapArray);
  }

  navigator.geolocation.getCurrentPosition(location_callback);
}


var loadGoogleMaps = function(latitude, longitude, locations, mainLocation) {
  // console.log(latitude, longitude)
  var mapProp = {
    center: new google.maps.LatLng(latitude, longitude),
    zoom: 16,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    streetViewControl: false,
    mapTypeControl: false
  };

  var mapMarkers = [];
  var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
  // loc = [ { lat: 40.7308361, lng: -73.9922004 },
  //         { lat: 40.7308370, lng: -73.9934135 },
  //         { lat: 40.7328370, lng: -73.9914135 }]

  mapMarkers[mapMarkers.length] = placeMarker(mainLocation, map, "red");
  for (var i=0; i < locations.length; i++) {
    mapMarkers[mapMarkers.length] = placeMarker(locations[i], map, "yellow");
  }


  return [mapMarkers, map];
  // google.maps.event.addDomListener(window, 'load', initialize);
}

var placeMarker = function(pos, map, color) {
  var marker = new google.maps.Marker( {  position: pos,
                                          icon: "http://maps.google.com/mapfiles/ms/icons/" + color + "-dot.png"
                                        } );
  marker.setMap(map);
  return marker;
}
