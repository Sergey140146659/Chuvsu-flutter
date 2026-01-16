import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'favorites_service_interface.dart';

class FavoritesService implements FavoritesServiceInterface {
  final CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');

  @override
  Future<List<String>> getFavorites() async {
    try {
      final snapshot = await favorites
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (!snapshot.exists) {
        return [];
      }

      final data = snapshot.data() as Map<String, dynamic>;
      return List<String>.from(data['items'] ?? []);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> addFavorite(String modelId) async {
    try {
      await favorites.doc(FirebaseAuth.instance.currentUser!.uid).set({
        'items': FieldValue.arrayUnion([modelId]),
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> removeFavorite(String modelId) async {
    try {
      await favorites.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'items': FieldValue.arrayRemove([modelId]),
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }
}
