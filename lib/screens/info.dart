import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  // ignore: use_super_parameters
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Group Name:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'COLLAB',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Group Topic:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Travel App',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Group Members:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            _buildMemberInfo('221110391', 'Alexandra'),
            _buildMemberInfo('221111366', 'Christopher Luhur'),
            _buildMemberInfo('221110108', 'Jocelyn'),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberInfo(String nim, String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            '$nim - ',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
