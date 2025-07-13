import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerWithPermissions extends StatefulWidget {
  final Function(File?)? onImageSelected;

  const ImagePickerWithPermissions({Key? key, this.onImageSelected})
      : super(key: key);

  @override
  State<ImagePickerWithPermissions> createState() =>
      _ImagePickerWithPermissionsState();
}

class _ImagePickerWithPermissionsState
    extends State<ImagePickerWithPermissions> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage; // 👉 para previsualizar

  // --------------------------- PERMISOS + PICK --------------------------- //
  Future<PermissionStatus> _requestGalleryPermission() async {
    if (Platform.isAndroid) {
      // 1️⃣ Primero intenta READ_MEDIA_IMAGES (API 33+).
      var status = await Permission.photos.request();

      // 2️⃣ Si seguimos en negado es porque estamos en API<=32.
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      return status;
    }
    // iOS / macOS
    return await Permission.photos.request();
  }

  Future<void> _checkAndRequestPermission(ImageSource source) async {
    try {
      PermissionStatus status;

      if (source == ImageSource.camera) {
        status = await Permission.camera.request();
      } else {
        status = await _requestGalleryPermission();
      }

      if (status.isGranted) {
        await _pickImage(source);
      } else if (status.isPermanentlyDenied) {
        _showPermissionSettingsDialog(
            source == ImageSource.camera ? 'cámara' : 'galería');
      } else {
        _showErrorDialog('Permiso necesario para continuar');
      }
    } catch (e) {
      _showErrorDialog('Error al solicitar permisos: $e');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: source, imageQuality: 80);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        setState(() => _selectedImage = file); // ← refresca preview
        widget.onImageSelected?.call(file);
      }
    } catch (e) {
      _showErrorDialog('Error al seleccionar imagen: $e');
    }
  }

  // --------------------------- DIÁLOGOS --------------------------- //

  void _showPermissionSettingsDialog(String permiso) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permiso requerido'),
        content: Text(
            'El permiso para acceder a la $permiso fue denegado permanentemente. '
            'Por favor, habilítalo en la configuración de la aplicación.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
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
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  // --------------------------- UI --------------------------- //

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
          // PREVIEW ─ solo si hay imagen
          if (_selectedImage != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                _selectedImage!,
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
          ],

          // BOTÓN CÁMARA
          GestureDetector(
            onTap: () => _checkAndRequestPermission(ImageSource.camera),
            child: Column(
              children: [
                const Icon(Icons.add_a_photo, size: 48, color: Colors.grey),
                const SizedBox(height: 8),
                Text('Tomar foto',
                    style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text('o',
              style: TextStyle(fontSize: 20, color: Colors.grey.shade400)),
          const SizedBox(height: 4),

          // BOTÓN GALERÍA
          OutlinedButton(
            onPressed: () => _checkAndRequestPermission(ImageSource.gallery),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            child: Text('Abrir galería',
                style: TextStyle(color: Colors.grey.shade600)),
          ),
        ],
      ),
    );
  }
}
