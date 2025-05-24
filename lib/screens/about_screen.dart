import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Color(0xFF128FFC),
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 32),
            _buildInfoSection(
              context,
              'Developer Name',
              'Dagmawi Minale',
              Icons.person_outline,
            ),
            const SizedBox(height: 24),
            _buildInfoSection(
              context,
              'ID Number',
              'UGR/8048/14',
              Icons.badge_outlined,
            ),
            const SizedBox(height: 24),
            _buildInfoSection(context, 'Section', '3', Icons.group_outlined),
            const SizedBox(height: 32),
            const Text(
              'About',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF128FFC),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'A passionate Flutter developer with a keen eye for creating beautiful and functional mobile applications. '
              'Currently pursuing studies in Computer Science, focusing on mobile app development and user experience design. '
              'This album viewer app is a demonstration of clean architecture, state management, and modern UI/UX practices.',
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF128FFC),
        child: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          tooltip: 'Home',
          onPressed: () => context.go('/'),
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF128FFC), size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
