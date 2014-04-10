mapInitialize =  ->
  myLatlng = new google.maps.LatLng(35.5544471, 139.6587877)
  mapOptions =
    center: myLatlng
    zoom: 14
  map = new google.maps.Map(document.getElementById("map-canvas"),mapOptions)
  marker = new google.maps.Marker
    position: myLatlng,
    map: map,
    title:"Hello World!"

$ mapInitialize
document.addEventListener('page:load', mapInitialize);

