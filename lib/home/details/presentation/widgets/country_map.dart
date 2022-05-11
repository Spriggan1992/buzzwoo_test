import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/presentation/app_icons.dart';
import '../../../core/presentation/widgets/icons/svg_icon.dart';

const _urlTemplate = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
const _mapAttribution = 'test_app';

/// Represent country location on the map.
class CountryMap extends StatelessWidget {
  /// Coordinates in degrees.
  final LatLng? latLng;
  const CountryMap({
    required this.latLng,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return latLng == null
        ? const Padding(
            padding: EdgeInsets.only(top: 30),
            child: SvgIcon(
              asset: AppIcons.earth,
            ),
          )
        : FlutterMap(
            options: MapOptions(
              swPanBoundary: latLng,
              interactiveFlags: InteractiveFlag.none,
              center: latLng,
              zoom: 8,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: _urlTemplate,
                subdomains: ['a', 'b', 'c'],
                attributionBuilder: (_) {
                  return const Text(_mapAttribution);
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    point: latLng!,
                    builder: (ctx) => const SizedBox(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
