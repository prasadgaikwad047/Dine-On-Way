import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_on_way/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final QueryDocumentSnapshot finaluserdoc;
  const MapScreen({super.key, required this.finaluserdoc});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  List<Marker> markers = [];
  LatLng _currentPosition = const LatLng(18.761225711454205, 73.4213639363347);

  @override
  void initState() {
    super.initState();
    _fetchMarkers();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: CustomNavBar(
        index: 1,
        finaluserdoc: widget.finaluserdoc,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: 12,
          ),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          markers: Set<Marker>.of(markers),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
      ]),
    );
  }

  void _fetchMarkers() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot =
        await firestore.collection('hotel list').get();

    setState(() {
      markers = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final lat = data['coordinate'].latitude;
        final lng = data['coordinate'].longitude;
        final marker = Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: data['title'],
            snippet: data['address'],
          ),
        );
        return marker;
      }).toList();
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position as LatLng;
        print(_currentPosition);
      });
    } catch (e) {
      print(e);
    }
  }
}
/* 
  Future<void> _getCurrentLocation() async {
    final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;
    await _geolocator
        .getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    )
        .then((position) {
      setState(() {
        _currentPosition = position as LatLng;
        markers.add(
          Marker(
            markerId: MarkerId('curr_loc'),
            position: LatLng(
              _currentPosition.latitude,
              _currentPosition.longitude,
            ),
          ),
        );
      });
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              _currentPosition.latitude,
              _currentPosition.longitude,
            ),
            zoom: 16,
          ),
        ),
      );
    }).catchError((e) {
      print(e);
    });
  } */
/*
  void _getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  } */


/*
class _MapScreenState extends State<MapScreen> {
  //final userRef = FirebaseFirestore.instance.collection('hotel list');
  final Map<String, Marker> _markers = {};
  final firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    _fetchCoordinatesFromFirestore();
  }

  void _fetchCoordinatesFromFirestore() async {
    final snapshot = await firestore.collection('hotel list').get();

    setState(() {
      for (final document in snapshot.docs) {
        final data = document.data();
        final geoPoint = data['coordinate'] as GeoPoint;
        // final lat = data['latitude'] as double;
        // final lng = data['longitude'] as double;
        final marker = Marker(
          markerId: MarkerId(document.id),
          position: LatLng(geoPoint.latitude, geoPoint.longitude),
          //position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: data['title'],
            snippet: data['address'],
          ),
        );
        _markers[document.id] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: CustomNavBar(
        index: 1,
        finaluserdoc: widget.finaluserdoc,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
                target: LatLng(18.7000127619561, 73.69398982203246), zoom: 10),
            markers: _markers.values.toSet(),
          )
        ],
      ),
    );
  }
} */

/*
class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(18.7000127619561, 73.69398982203246),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(18.7000127619561, 73.69398982203246),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}*/
