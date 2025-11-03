import 'package:flutter/material.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({
    super.key,
    required this.contentId,
  });

  final String contentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content ID: $contentId'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.asset(
              'assets/images/photo1.jpg',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Detailed information for item with ID $contentId will be here.',
            ),
          ),
        ],
      ),
    );
  }
}
