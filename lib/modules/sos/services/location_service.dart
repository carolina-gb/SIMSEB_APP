import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrent() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('GPS apagado');
    }

    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied) {
        throw Exception('Permiso denegado');
      }
    }
    if (perm == LocationPermission.deniedForever) {
      throw Exception('Permiso denegado para siempre');
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
