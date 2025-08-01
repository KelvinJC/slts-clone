import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// 1) Pick & crop a license‑plate‑shaped image.
Future<File?> pickAndCropPlateImage(ImageSource source) async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: source, imageQuality: 85);
  if (picked == null) return null;

  final cropped = await ImageCropper().cropImage(
    sourcePath: picked.path,
    // aspectRatioPresets: [CropAspectRatioPreset.ratio4x1, CropAspectRatioPreset.ratio16x9],
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Plate',
        hideBottomControls: true,
        lockAspectRatio: false,
      ),
      IOSUiSettings(title: 'Crop Plate'),
    ],
  );
  return (cropped == null) ? null : File(cropped.path);
}

/// 2) Run ML Kit OCR on a File and return every line of text.
Future<List<String>> recognizeTextFromImage(File imageFile) async {
  final inputImage = InputImage.fromFile(imageFile);
  final recognizer = TextRecognizer();
  final visionText = await recognizer.processImage(inputImage);
  await recognizer.close();

  final lines = <String>[];
  for (final block in visionText.blocks) {
    for (final line in block.lines) {
      final txt = line.text.trim();
      if (txt.isNotEmpty) lines.add(txt);
    }
  }
  return lines;
}

/// Simple heuristic to rank plate candidates:
/// – only A–Z or 0–9 allowed
/// – preferred length 5–8
int _plateScore(String s) {
  final alphaNum = RegExp(r'^[A-Z0-9]+$');
  if (!alphaNum.hasMatch(s)) return -100;
  // if (s.length < 5 || s.length > 8) return -50;
  return s.length;
}

/// 3) The end‑to‑end “pick → crop → OCR → choose” flow.
///
/// When the user taps “Quick Capture”, call this:
///
/// ```dart
/// import 'package:your_app/utils/ocr_utils.dart';
///
/// onTap: () => detectPlateAndNavigate(context, onSelected: (plate) {
///   _controller.text = plate;
///   ... navigate to SearchScreen ...
/// });
/// ```
Future<void> detectPlateAndNavigate(
  BuildContext context, {
  required void Function(String plateText) onSelected,
}) async {
  // Step 1: choose source
  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Take Photo'),
          onTap: () => Navigator.pop(ctx, ImageSource.camera),
        ),
        ListTile(
          leading: Icon(Icons.photo_library),
          title: Text('Choose from Gallery'),
          onTap: () => Navigator.pop(ctx, ImageSource.gallery),
        ),
      ],
    ),
  );
  if (source == null) return;

  // Step 2: crop
  final img = await pickAndCropPlateImage(source);
  if (img == null) return;

  // Step 3: OCR
  final rawLines = await recognizeTextFromImage(img);
  // final scored = rawLines
  //     .map((l) => MapEntry(l.toUpperCase(), _plateScore(l.toUpperCase())))
  //     .where((e) => e.value > 0)
  //     .toList();
  final scored = rawLines
      .map((l) => MapEntry(l.toUpperCase(), _plateScore(l.toUpperCase())))
      .toList();
  if (scored.isEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('No valid plate candidates found')));
    return;
  }
  scored.sort((a, b) => b.value.compareTo(a.value));

  // Step 4: let user filter & pick
  String filter = '';
  final choice = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(ctx).canvasColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: StatefulBuilder(
              builder: (cctx, setState) {
                return Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Filter results…',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (v) =>
                          setState(() => filter = v.toUpperCase()),
                    ),
                    SizedBox(height: 12),
                    //add select text
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Capture results, select a plate number'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: scored.length,
                        itemBuilder: (_, i) {
                          final txt = scored[i].key;
                          if (filter.isNotEmpty && !txt.contains(filter)) {
                            return SizedBox.shrink();
                          }
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              title: Text(
                                txt,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              // subtitle: Text(
                              //   'Confidence: ${scored[i].value}/8',
                              // ),
                              onTap: () => Navigator.pop(ctx, txt),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    },
  );

  if (choice != null) onSelected(choice);
}
