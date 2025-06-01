import 'package:flutter/material.dart';
import '../models/doctor.dart';

class DoctorListItemWidget extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  const DoctorListItemWidget({
    super.key,
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(doctor.imageUrl),
          onBackgroundImageError: (_, __) {},
          child: doctor.imageUrl.contains('placeholder') 
              ? const Icon(Icons.person, size: 30)
              : null,
        ),
        title: Text(
          doctor.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              doctor.specialty,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              doctor.bio,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text('View Schedule'),
        ),
        contentPadding: const EdgeInsets.all(16),
        isThreeLine: true,
      ),
    );
  }
}
