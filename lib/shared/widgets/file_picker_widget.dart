import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerWithPermissions extends StatefulWidget {
  final Function(File?)? onImageSelected;

  const ImagePickerWithPermissions({Key? key, this.onImageSelected}) : super(key: key);

  @override
  State<ImagePickerWithPermissions> createState() => _ImagePickerWithPermissionsState();
}

class _ImagePickerWithPermissionsState extends State<ImagePickerWithPermissions> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _checkAndRequestPermission(ImageSource source) async {
    try {
      PermissionStatus status;

      if (source == ImageSource.camera) {
        status = await Permission.camera.request();
      } else if (Platform.isAndroid) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.photos.request();
      }

      if (status.isGranted) {
        await _pickImage(source);
      } else if (status.isPermanentlyDenied) {
        _showPermissionSettingsDialog(source == ImageSource.camera ? 'cámara' : 'galería');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permiso necesario para continuar')),
        );
      }
    } catch (e) {
      _showErrorDialog('Error al solicitar permisos: $e');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 80);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        widget.onImageSelected?.call(file);
      }
    } catch (e) {
      _showErrorDialog('Error al seleccionar imagen: $e');
    }
  }

  void _showPermissionSettingsDialog(String permiso) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permiso requerido'),
        content: Text('El permiso para acceder a la $permiso fue denegado permanentemente. '
            'Por favor, habilítalo en la configuración de la aplicación.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Abrir configuración'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _checkAndRequestPermission(ImageSource.camera),
            child: Column(
              children: [
                const Icon(Icons.add_photo_alternate_outlined, size: 48, color: Colors.grey),
                const SizedBox(height: 8),
                Text('Tomar foto', style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text('o', style: TextStyle(fontSize: 20, color: Colors.grey.shade400)),
          const SizedBox(height: 4),
          OutlinedButton(
            onPressed: () => _checkAndRequestPermission(ImageSource.gallery),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            child: Text('Abrir galería', style: TextStyle(color: Colors.grey.shade600)),
          ),
        ],
      ),
    );
  }
}
