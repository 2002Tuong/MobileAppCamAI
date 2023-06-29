// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:cloudgo_mobileapp/widgets/appbar_widget.dart';
import 'package:cloudgo_mobileapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';

class CheckGPS extends StatefulWidget {
  const CheckGPS({super.key});

  @override
  State<CheckGPS> createState() => _CheckGPSState();
}

class _CheckGPSState extends State<CheckGPS> {
  final GlobalKey<ScaffoldState> _hello = GlobalKey<ScaffoldState>();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String address = "";
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showSnackbar(context, Colors.red,
              "Vui lòng cấp quyền truy cấp vị trí của ứng dụng");
        } else if (permission == LocationPermission.deniedForever) {
          showSnackbar(context, Colors.red,
              "Vui lòng cấp quyền truy cấp vị trí của ứng dụng");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });
        showSnackbar(context, Colors.red, "Cập nhật vị trí thành công");
        getLocation();
      }
    } else {
      showSnackbar(context, Colors.red, "Dịch vụ GPS không hoạt động");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    // ignore: unused_local_variable
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    tilt: 59.440717697143555,
    target: LatLng(10.838766, 106.655297),
    zoom: 19.151926040649414,
    bearing: 192.8334901395799,
  );
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(10.838766, 106.655297),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _hello,
      appBar: AppBarWidget(
        titlebar: 'CHECK-IN GPS',
        scaffoldKey: _hello,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: {
                Marker(
                  markerId: const MarkerId('locationMarker'),
                  position: _kLake.target,
                ),
              },
              zoomControlsEnabled: false,
            ),
          ),
          Column(children: [
            //Kiểm Tra App bật không
            Text(servicestatus ? "GPS is Enabled" : "GPS is disabled."),
            //Quyền truy cập của App
            Text(haspermission ? "GPS is Enabled" : "GPS is disabled."),
            Text("Longitude: $long", style: const TextStyle(fontSize: 20)),
            Text(
              "Latitude: $lat",
              style: const TextStyle(fontSize: 20),
            ),
            Text("Address: $address"),
          ])
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _getAddress(position.latitude, position.longitude).then((value) {
            setState(() {
              address = value;
            });
          });
        },
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
      drawer: AppBarWidget.buildDrawer(context),
    );
  }

  Future<String> _getAddress(double? lat, double? lang) async {
    if (lat == null || lang == null) return "";
    GeoCode geoCode = GeoCode();
    Address address =
        await geoCode.reverseGeocoding(latitude: lat, longitude: lang);

    return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
  }
}
