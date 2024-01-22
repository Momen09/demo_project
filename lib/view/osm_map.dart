import 'package:demo_project/view/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class OsmMap extends StatefulWidget {
  const OsmMap({super.key});

  static const routeName = 'OsmMap';

  @override
  State<OsmMap> createState() => _OsmMapState();
}

class _OsmMapState extends State<OsmMap> {
  final MapController mapController =
      MapController(initMapWithUserPosition: true);

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OSMFlutter(
            controller: mapController,
            mapIsLoading: const LoadingScreen(),
            trackMyPosition: true,
            initZoom: 12,
            minZoomLevel: 4,
            maxZoomLevel: 14,
            stepZoom: 1,
            androidHotReloadSupport: true,
            userLocationMarker: UserLocationMaker(
              personMarker: const MarkerIcon(
                icon: Icon(
                  Icons.personal_injury,
                  color: Colors.black,
                  size: 48,
                ),
              ),
              directionArrowMarker: const MarkerIcon(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 48,
                ),
              ),
            ),

            roadConfiguration: RoadConfiguration(roadColor: Colors.blueGrey),
            markerOption: MarkerOption(
                defaultMarker: const MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.black,
                size: 48,
              ),
            )),
            onMapIsReady: (isReady) async {
              if (isReady) {
                await Future.delayed(const Duration(seconds: 1), () async {
                  await mapController.currentLocation();
                });
              }
            }));
  }
}
