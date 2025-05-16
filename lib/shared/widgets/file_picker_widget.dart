import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerWithPermissions extends StatefulWidget {
  final Function(File?)? onImageSelected;
  final double? size;

  const ImagePickerWithPermissions({
    Key? key,
    this.onImageSelected,
    this.size = 120,
  }) : super(key: key);

  @override
  _ImagePickerWithPermissionsState createState() => _ImagePickerWithPermissionsState();
}

class _ImagePickerWithPermissionsState extends State<ImagePickerWithPermissions> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _checkAndRequestPermission(ImageSource source) async {
    try {
      PermissionStatus status;
      if (source == ImageSource.camera) {
        status = await Permission.camera.request();
        if (status == PermissionStatus.permanentlyDenied) {
          _showPermissionSettingsDialog('cámara');
          return;
        }
      } else {
        if (Platform.isAndroid) {
          status = await Permission.storage.request();
        } else {
          status = await Permission.photos.request();
        }
        
        if (status == PermissionStatus.permanentlyDenied) {
          _showPermissionSettingsDialog('galería');
          return;
        }
      }

      if (status.isGranted) {
        await _pickImage(source);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permiso necesario para continuar')),
        );
      }
    } catch (e) {
      _showErrorDialog('Error al solicitar permisos: $e');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        widget.onImageSelected?.call(_imageFile);
      }
    } catch (e) {
      _showErrorDialog('Error al seleccionar imagen: $e');
    }
  }

  void _showPermissionSettingsDialog(String permission) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permiso requerido'),
        content: Text(
          'El permiso para acceder a la $permission fue denegado permanentemente. '
          'Por favor, habilítalo en la configuración de la aplicación.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: Text('Abrir configuración'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildImage() {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
        image: _imageFile != null
            ? DecorationImage(
                image: FileImage(_imageFile!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: _imageFile == null
          ? Icon(Icons.camera_alt, size: widget.size! * 0.3)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showSourceDialog(),
          child: _buildImage(),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              icon: Icons.camera_alt,
              text: 'Cámara',
              onTap: () => _checkAndRequestPermission(ImageSource.camera),
            ),
            SizedBox(width: 20),
            _buildButton(
              icon: Icons.photo_library,
              text: 'Galería',
              onTap: () => _checkAndRequestPermission(ImageSource.gallery),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 18),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onPressed: onTap,
    );
  }

  void _showSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Seleccionar imagen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Tomar foto'),
              onTap: () {
                Navigator.pop(context);
                _checkAndRequestPermission(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Elegir de galería'),
              onTap: () {
                Navigator.pop(context);
                _checkAndRequestPermission(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}