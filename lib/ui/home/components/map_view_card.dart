import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewCard extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapViewCard({
    this.latitude,
    this.longitude,
  });

  @override
  _MapViewCardState createState() => _MapViewCardState();
}

class _MapViewCardState extends State<MapViewCard> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Completer<GoogleMapController> _controller = Completer();

    return GoogleMap(
      mapType: MapType.normal,
      zoomControlsEnabled: false,
      compassEnabled: true,
      zoomGesturesEnabled: true,
      rotateGesturesEnabled: true,
      buildingsEnabled: true,
      scrollGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.latitude, 
          widget.longitude,
        ),
        zoom: 15.4746,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}