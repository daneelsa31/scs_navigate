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

  Stream<List<Opportunity>> getAllOpportunities() {
    return _opportunities.snapshots().map((snapshot) {
      return snapshot.docs
          .map(Opportunity.fromFirestore)
          .toList();
    });
  }

  Future<void> addOpportunity(
    Opportunity opportunity,
  ) async {
    await _opportunities.add(
      opportunity.toFirestore(),
    );
  }

  Future<void> updateOpportunity(
    Opportunity opportunity,
  ) async {
    await _opportunities
        .doc(opportunity.id)
        .update(opportunity.toFirestore());
  }

  Future<void> deleteOpportunity(
    String id,
  ) async {
    await _opportunities.doc(id).delete();
  }

  Future<void> archiveOpportunity(
    String id,
    bool archived,
  ) async {
    await _opportunities.doc(id).update({
      'isArchived': archived,
    });
  }

  Future<void> changePublication(
    String id,
    bool published,
  ) async {
    await _opportunities.doc(id).update({
      'isPublished': published,
    });
  }

  Future<void> changeStatus(
    String id,
    String status,
  ) async {
    await _opportunities.doc(id).update({
      'status': status,
    });
  }
}