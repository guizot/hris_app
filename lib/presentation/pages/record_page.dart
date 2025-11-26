import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isLoading = true;
  String? _errorMessage;
  
  // Attendance data
  String? _clockInTime;
  String? _clockOutTime;
  String _currentLocation = 'Getting location...';
  
  // Mock attendance data (replace with actual data from your backend)
  final bool _isClockedIn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _getCurrentLocation();
    _loadTodayAttendance();
  }

  Future<void> _initializeCamera() async {
    try {
      // Request camera permission
      final cameraStatus = await Permission.camera.request();
      
      if (!cameraStatus.isGranted) {
        setState(() {
          _errorMessage = 'Camera permission denied';
          _isLoading = false;
        });
        return;
      }

      // Get available cameras
      _cameras = await availableCameras();
      
      if (_cameras == null || _cameras!.isEmpty) {
        setState(() {
          _errorMessage = 'No cameras available';
          _isLoading = false;
        });
        return;
      }

      // Use front camera for selfie
      final frontCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error initializing camera: $e';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationStatus = await Permission.location.request();
      
      if (!locationStatus.isGranted) {
        setState(() {
          _currentLocation = 'Location permission denied';
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // In a real app, you would use geocoding to get the address
      // For now, showing coordinates
      setState(() {
        _currentLocation = '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
      });
    } catch (e) {
      setState(() {
        _currentLocation = 'Unable to get location';
      });
    }
  }

  void _loadTodayAttendance() {
    // Mock data - replace with actual API call
    setState(() {
      _clockInTime = '08:00 AM';
      _clockOutTime = null; // Not clocked out yet
    });
  }

  Future<void> _captureAndRecord() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final image = await _cameraController!.takePicture();
      
      // TODO: Upload image and record attendance
      // For now, just show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isClockedIn ? 'Clocked out successfully!' : 'Clocked in successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navigate back
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error capturing photo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(_isClockedIn ? 'Clock Out' : 'Clock In'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Camera preview - expands until location component
                      if (_isCameraInitialized)
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: CameraPreview(_cameraController!),
                            ),
                          ),
                        ),
                      
                      const SizedBox(height: 20),
                      
                      // Location info
                      _buildLocationCard(),
                      
                      const SizedBox(height: 20),
                      
                      // Capture button - full width
                      _buildCaptureButton(),
                      
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
    );
  }

  Widget _buildAttendanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTimeInfo(
                context,
                'Clock In',
                _clockInTime ?? '--:--',
                Icons.login,
                _clockInTime != null,
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.grey.shade300,
              ),
              _buildTimeInfo(
                context,
                'Clock Out',
                _clockOutTime ?? '--:--',
                Icons.logout,
                _clockOutTime != null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(
    BuildContext context,
    String label,
    String time,
    IconData icon,
    bool isActive,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24,
          color: isActive ? Theme.of(context).colorScheme.primary : Colors.grey,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isActive ? Theme.of(context).colorScheme.primary : Colors.grey,
              ),
        ),
      ],
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Location',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _currentLocation,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaptureButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _captureAndRecord,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isClockedIn ? Icons.logout : Icons.login,
              size: 24,
            ),
            const SizedBox(width: 12),
            const Text(
              'Capture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
