import 'package:dono/constants/utils.dart';
import 'package:dono/models/shop_owners.dart';
import 'package:dono/pages/confirmation.dart';
import 'package:dono/providers/shop_ownerprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String crNumber,
    required String phoneNumber,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ShopOwner shopOwner = ShopOwner(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        type: 'shopOwner',
        phoneNumber: phoneNumber,
        crNumber: crNumber,
        status: false,
      );

      await _database
          .child('shopOwners/${userCredential.user!.uid}')
          .set(shopOwner.toMap());

      showSnackBar(context,
          "Account has been created. Please login with your credentials.");
      Navigator.pushNamed(context, RegistrationConfirmationPage.routeName);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DatabaseEvent event = await _database
          .child('shopOwners/${userCredential.user!.uid}')
          .once();

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> userData =
            event.snapshot.value as Map<dynamic, dynamic>;
        ShopOwner shopOwner =
            ShopOwner.fromMap(Map<String, dynamic>.from(userData));

        if (shopOwner.type != 'shopOwner') {
          showSnackBar(context, "You're not a shop owner.");
          await _auth.signOut();
          return;
        }

        Provider.of<ShopOwnerProvider>(context, listen: false)
            .setShopOwner(shopOwner);
      } else {
        showSnackBar(context, "User not found.");
        await _auth.signOut();
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DatabaseEvent event =
            await _database.child('shopOwners/${user.uid}').once();

        if (event.snapshot.value != null) {
          Map<dynamic, dynamic> userData =
              event.snapshot.value as Map<dynamic, dynamic>;
          ShopOwner shopOwner =
              ShopOwner.fromMap(Map<String, dynamic>.from(userData));

          Provider.of<ShopOwnerProvider>(context, listen: false)
              .setShopOwner(shopOwner);
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Provider.of<ShopOwnerProvider>(context, listen: false).clearShopOwner();
      // Navigate to login screen or wherever you want after sign out
    } catch (e) {
      showSnackBar(context, "Error signing out: $e");
    }
  }
}
