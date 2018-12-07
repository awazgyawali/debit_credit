import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FirebaseHelper {
  static final FirebaseHelper _singleton = FirebaseHelper._internal();

  factory FirebaseHelper() {
    return _singleton;
  }

  FirebaseHelper._internal();

  SharedPreferences _preferences;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  FirebaseMessaging _messaging = FirebaseMessaging();
  Firestore _firestore = Firestore();

  FirebaseUser user;

  init() async {
    _preferences = await SharedPreferences.getInstance();
    return user = await _auth.currentUser();
  }

  Future loginViaEmailPassword(email, password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    await _firestore.collection("users").document(user.uid).setData({
      "name": user.displayName,
      "email": user.email,
      "phone": user.phoneNumber,
      "photo_url": user.photoUrl,
      "uid": user.uid,
      "token": await _messaging.getToken(),
      "last_signed_in": user.metadata.lastSignInTimestamp,
      "created_at": user.metadata.creationTimestamp,
      "provider_id": user.providerId
    });
    await init();
  }

  Future loginWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    GoogleSignInAccount account = await _googleSignIn.signIn();
    GoogleSignInAuthentication authentication = await account.authentication;

    user = await _auth.signInWithGoogle(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);
    return user;
  }

  forgotPassword(email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future loginWithFacebook() async {
    var result = await FacebookLogin().logInWithReadPermissions(['email']);
    if (result.status == FacebookLoginStatus.loggedIn) {
      user =
          await _auth.signInWithFacebook(accessToken: result.accessToken.token);
      return user;
    } else if (result.status == FacebookLoginStatus.error)
      throw PlatformException(code: "ERROR", message: result.errorMessage);
    else
      return null;
  }

  Future createAccount(name, email, password, File image) async {
    //creating user
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    //renaming the file
    var name = user.uid + "." + image.path.split(".")[1];
    //uploading image
    _storage
        .ref()
        .child("/profile_pictures/$name")
        .putFile(await compressImage(image));
    var info = UserUpdateInfo();
    info.displayName = name;
    info.photoUrl =
        "https://firebasestorage.googleapis.com/v0/b/debit-credit-tracker.appspot.com/o/profile_pictures%2F$name?alt=media";
    await user.updateProfile(info);
    await _firestore.collection("users").document(user.uid).setData({
      "name": name,
      "email": user.email,
      "photo_url": info.photoUrl,
      "uid": user.uid,
      "token": await _messaging.getToken(),
      "last_signed_in": user.metadata.lastSignInTimestamp,
      "created_at": user.metadata.creationTimestamp,
      "provider_id": user.providerId
    });
    await init();
  }

  Future addFinanceAccount(name, mobile, image) async {
    var fName = _randomString(20) + ".jpg";
    //uploading image
    _storage
        .ref()
        .child("/account_images/$fName")
        .putFile(await compressImage(image));

    await _database
        .reference()
        .child("user_data/${user.uid}/accounts")
        .push()
        .set({
      "name": name,
      "mobile": mobile,
      "photo_url":
          "https://firebasestorage.googleapis.com/v0/b/debit-credit-tracker.appspot.com/o/account_images%2F$fName?alt=media",
      "total": 0,
    });
  }

  Future addTransaction(key, type, account, amount, detail) async {
    await _database
        .reference()
        .child("user_data/${user.uid}/transactions")
        .push()
        .set({
      "type": type,
      "account_key": key,
      "account_name": account["name"],
      "photo_url": account["photo_url"],
      "amount": double.parse(amount),
      "detail": detail,
    });
  }

  deleteAccount(key) {
    _database.reference().child("user_data/${user.uid}/accounts/$key").remove();
  }

  Stream getAccounts() {
    return _database
        .reference()
        .child("user_data/${user.uid}/accounts")
        .onValue;
  }

  Stream getTransactions() {
    return _database
        .reference()
        .child("user_data/${user.uid}/transactions")
        .onValue;
  }

  Future logout() async {
    if (user != null) {
      await _auth.signOut();
      await init();
    }
  }

  Future<File> compressImage(file) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Random().nextInt(10000);

    Im.Image image = Im.decodeImage(file.readAsBytesSync());
    Im.Image smallerImage = Im.copyResize(image, 300);

    return File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(smallerImage, quality: 80));
  }

  String _randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }
}
