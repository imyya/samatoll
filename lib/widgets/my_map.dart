import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:samatoll/controller/location_controller.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final LocationController _locationController = Get.put(LocationController());
  GoogleMapController? mapController;
  // late LatLng startLocation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_locationController.currentLatitude.value == 0.0 &&
          _locationController.currentLongitude.value == 0.0) {
        return const Center(child: CircularProgressIndicator());
      } else {
        final startLocation = LatLng(
      _locationController.currentLatitude.value,
      _locationController.currentLongitude.value,
    );
        return GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: startLocation,

            zoom: 18.0,
          ),

          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
        );
      }
    });
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
