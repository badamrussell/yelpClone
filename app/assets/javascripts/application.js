// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


//----- POPUPS

var closePopup = function() {
  $pop = $(".popup-show");

  if ($pop) { $pop.removeClass("popup-show") }
  if ($pop) { $pop.addClass("popup-hide") }
  console.log("CLOSE", $pop);
}

var showPopup = function(popupName, id) {
  closePopup();

  $pop = $("." + popupName);
  console.log("OPEN", $pop, popupName, id);
  if ($pop) {
    $pop.addClass("popup-show");
    $a = $pop.find(".main-id")
    $a.attr("value", id)
  }
  console.log("OPEN", $pop, popupName);
}


// ----------- GOOGLE PLACES API

var placeSearch = function(event) {
  console.log(event);
  $.ajax({
    url: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyCtQ4rA385P05RHibxx6TdTP_m2_VwEo2Y&keyword=pizza&location=40.751402%2C-73.9898218&radius=2000&sensor=false&type=restaurant",
    type: "GET",
    success: function(e) {
      alert("it worked?");
      console.log(e);
    }

  });

}

// ----------- GOOGLE MAPS API

var getLocation = function(locations) {
  var location_callback = function(geoPosition) {
    console.log(geoPosition, geoPosition.coords)
    var coords = geoPosition.coords;
    var map = loadGoogleMaps(coords.latitude, coords.longitude, locations);

    loc = { lat: 40.7308361, lng: -73.9922004 }
    //locLit = "" + 40.7308361 + "," + -73.9922004;
    //placeMarker(loc, map);
    // for (var i=0; i < loc.length; i++) {
    //   placeMarker(loc[i], map);
    // }
  }
  navigator.geolocation.getCurrentPosition(location_callback);
}


var loadGoogleMaps = function(latitude, longitude, locations) {
  console.log(latitude, longitude)
  var mapProp = {
    center:new google.maps.LatLng(latitude, longitude),
    zoom:16,
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };

  var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
  // loc = [ { lat: 40.7308361, lng: -73.9922004 },
  //         { lat: 40.7308370, lng: -73.9934135 },
  //         { lat: 40.7328370, lng: -73.9914135 }]
  for (var i=0; i < locations.length; i++) {
    placeMarker(locations[i], map);
  }

  // google.maps.event.addDomListener(window, 'load', initialize);
}

var placeMarker = function(pos, map) {
  var marker = new google.maps.Marker( { position: pos } );
  marker.setMap(map);
}