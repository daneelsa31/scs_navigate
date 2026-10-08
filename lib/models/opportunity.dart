import 'package:cloud_firestore/cloud_firestore.dart';

class Opportunity {
  final String id;
  final String title;
  final String organizer;
  final String category;
  final String description;
  final String deadline;
  final String status;
  final String location;
  final String registrationLink;
  final List<String> eligibility;
  final List<String> perks;
  final bool isPublished;
  final bool isArchived;

  const Opportunity({
    required this.id,
    required this.title,
    required this.organizer,
    required this.category,
    required this.description,
    required this.deadline,
    required this.status,
    required this.location,
    required this.registrationLink,
    required this.eligibility,
    required this.perks,
    required this.isPublished,
    required this.isArchived,
  });

  factory Opportunity.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    return Opportunity(
      id: doc.id,
      title: data['title'] ?? '',
      organizer: data['organizer'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      deadline: data['deadline'] ?? '',
      status: data['status'] ?? '',
      location: data['location'] ?? 'To be announced',
      registrationLink: data['registrationLink'] ?? '',
      eligibility: List<String>.from(
        data['eligibility'] ?? [],
      ),
      perks: List<String>.from(
        data['perks'] ?? [],
      ),
      isPublished: data['isPublished'] ?? false,
      isArchived: data['isArchived'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'organizer': organizer,
      'category': category,
      'description': description,
      'deadline': deadline,
      'status': status,
      'location': location,
      'registrationLink': registrationLink,
      'eligibility': eligibility,
      'perks': perks,
      'isPublished': isPublished,
      'isArchived': isArchived,
    };
  }
}