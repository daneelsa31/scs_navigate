import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/opportunity.dart';

class OpportunityService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>>
      get _opportunities {
    return _firestore.collection('opportunities');
  }

  Stream<List<Opportunity>> getPublicOpportunities() {
    return _opportunities.snapshots().map((snapshot) {
      return snapshot.docs
          .map(Opportunity.fromFirestore)
          .where(
            (opportunity) =>
                opportunity.isPublished &&
                !opportunity.isArchived,
          )
          .toList();
    });
  }
}