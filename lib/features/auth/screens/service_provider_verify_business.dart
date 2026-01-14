import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workpleis/features/auth/screens/account_successful.dart';

class ServiceProviderVerifyBusiness extends StatefulWidget {
  const ServiceProviderVerifyBusiness({super.key});
  static const routeName = '/service_verify-business';
  @override
  State<ServiceProviderVerifyBusiness> createState() =>
      _ServiceProviderVerifyBusinessState();
}

class _ServiceProviderVerifyBusinessState
    extends State<ServiceProviderVerifyBusiness> {
  File? _documentImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _documentImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            /// Title
            const Text(
              "Verify your Business",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            /// Subtitle
            const Text(
              "Place your document into the frame and take a clear photo",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const SizedBox(height: 24),

            /// Document label
            const Text(
              "Document",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            /// Upload Box
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                  ),
                ),
                child: _documentImage == null
                    ? const Center(
                        child: Icon(
                          Icons.upload_rounded,
                          size: 40,
                          color: Colors.black54,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.file(_documentImage!, fit: BoxFit.cover),
                      ),
              ),
            ),

            const Spacer(),

            /// Continue Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _documentImage == null
                    ? null
                    : () {
                        // Navigate to Account Successful screen
                        context.push(AccountSuccessful.routeName);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B0F2F),
                  disabledBackgroundColor: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
