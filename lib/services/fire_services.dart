// import 'package:clean_app/models/book.dart';
// import 'package:clean_app/models/location.dart';
// import 'package:clean_app/models/service.dart';
// import 'package:clean_app/views/cart_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class FireService {
//   static Stream<List<Service>> getServices() => FirebaseFirestore.instance
//       .collection('services')
//       .snapshots()
//       .map((snapshot) =>
//           snapshot.docs.map((doc) => Service.fromJson(doc.data())).toList());

//   static Stream<List<Location>> getLocations(String id) => FirebaseFirestore
//       .instance
//       .collection("service-location")
//       .where("service-id", isEqualTo: "7WFeiBlUllVLBkzFF7ey")
//       .snapshots()
//       .map((snapshot) =>
//           snapshot.docs.map((doc) => Location.fromJson(doc.data())).toList());

//   static Future putBook(
//       {required BuildContext context,
//       required String userId,
//       required int beds,
//       required int cleaners,
//       required Timestamp date,
//       required int hours,
//       required List<String> location,
//       required Map<String, int> materials,
//       required int price,
//       required String serviceId,
//       required String serviceName,
//       required String img}) async {
//     final String bookingId =
//         FirebaseFirestore.instance.collection("booking").doc().id;
//     final book =
//         FirebaseFirestore.instance.collection("booking").doc(bookingId);
//     final bookItem = Book(
//         bookingId: bookingId,
//         serviceName: serviceName,
//         img: img,
//         userId: userId,
//         beds: beds,
//         cleaners: cleaners,
//         date: date,
//         hours: hours,
//         location: location,
//         materials: materials,
//         price: price,
//         serviceId: serviceId,
//         status: 0);

//     final json = bookItem.toJson();
//     await book
//         .set(json)
//         .then((value) => Navigator.push(
//             context, MaterialPageRoute(builder: (context) => CartScreen())))
//         .catchError((error) {
//       print("Some Error Occured");
//     });
//   }

//   static Stream<List<Book>> getBook(String id) => FirebaseFirestore.instance
//       .collection("booking")
//       .where("user-id", isEqualTo: id)
//       .snapshots()
//       .map((snapshot) =>
//           snapshot.docs.map((doc) => Book.fromJson(doc.data())).toList());

//   static Stream<List<Book>> activeOrders(String id) =>
//       FirebaseFirestore.instance
//           .collection("booking")
//           .where("status", isEqualTo: 1)
//           .where("user-id", isEqualTo: id)
//           .snapshots()
//           .map((snapshot) =>
//               snapshot.docs.map((doc) => Book.fromJson(doc.data())).toList());

//   static Stream<List<Book>> completeOrders(String id) =>
//       FirebaseFirestore.instance
//           .collection("booking")
//           .where("status", isEqualTo: 2)
//           .where("user-id", isEqualTo: id)
//           .snapshots()
//           .map((snapshot) =>
//               snapshot.docs.map((doc) => Book.fromJson(doc.data())).toList());

//   static deleteBook(String id) =>
//       FirebaseFirestore.instance.collection("booking").doc(id).delete();

//   static Future signInFire(String user, String pass) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: user, password: pass);
//     } on FirebaseAuthException catch (e) {
//       print(e);
//     }
//   }

//   static Future signUpFire(String user, String pass) async {
//     try {
//       await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: user, password: pass);
//     } on FirebaseAuthException catch (e) {
//       print(e);
//     }
//   }
// }

import 'dart:typed_data';

import 'package:clean_admin/components/constants.dart';
import 'package:clean_admin/models/book.dart';
import 'package:clean_admin/models/cleaner.dart';
import 'package:clean_admin/models/location_add.dart';
import 'package:clean_admin/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FireService {
  static Stream<List<Service>> getServices() => FirebaseFirestore.instance
      .collection('services')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Service.fromJson(doc.data())).toList());

  static Stream<List<Cleaner>> getCleaners() => FirebaseFirestore.instance
      .collection('cleaners')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cleaner.fromJson(doc.data())).toList());
  static Stream<List<Cleaner>> getOnlineCleaners() => FirebaseFirestore.instance
      .collection('cleaners')
      .where("status", isEqualTo: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cleaner.fromJson(doc.data())).toList());

  static Stream<List<Book>> getBooks(
      {required Timestamp sTime,
      required Timestamp eTime,
      required bool mode}) {
    if (!mode) {
      return FirebaseFirestore.instance
          .collection("booking")
          .where('date', isGreaterThan: sTime)
          .where('date', isLessThan: eTime)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Book.fromJson(doc.data())).toList());
    }
    return FirebaseFirestore.instance.collection("booking").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Book.fromJson(doc.data())).toList());
  }

  static Stream<List<Book>> getAcceptBooks() => FirebaseFirestore.instance
      .collection("booking")
      .where("status", isEqualTo: 1)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Book.fromJson(doc.data())).toList());

  static Stream<List<Book>> getRejectBooks() => FirebaseFirestore.instance
      .collection("booking")
      .where("status", isEqualTo: 2)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Book.fromJson(doc.data())).toList());

  static UploadTask? uploadImage(String destination, Uint8List file) {
    try {
      final ref = FirebaseStorage.instance.ref();
      return ref.child(destination).putData(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static Future addServive(
      {required BuildContext context,
      required int price,
      required List<LocationAdd> locationData,
      required String serviceName,
      required String img}) async {
    final String serviceId =
        FirebaseFirestore.instance.collection("services").doc().id;
    final service =
        FirebaseFirestore.instance.collection("services").doc(serviceId);
    final serviceItem =
        Service(id: serviceId, img: img, name: serviceName, price: price);
    final json1 = serviceItem.toJson();
    await service.set(json1);
  }

  static Future addCleaner({
    required BuildContext context,
    required cleanerName,
    required serviceName,
    required cleanerAddress,
    required cleanerMobile,
  }) async {
    final String cleanerId =
        FirebaseFirestore.instance.collection("cleaners").doc().id;
    final cleaner =
        FirebaseFirestore.instance.collection("cleaners").doc(cleanerId);
    final cleanerItem = Cleaner(
        cleanerName: cleanerName,
        serviceName: serviceName,
        cleanerAddress: cleanerAddress,
        cleanerMobile: cleanerMobile,
        cleanerId: cleanerId);
    final json = cleanerItem.toJson();
    await cleaner
        .set(json)
        .then((value) => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Service Added Successfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: primaryColor),
                ),
                content: SizedBox(
                  width: 300,
                  height: 300,
                  child: ListView(
                    controller: ScrollController(),
                    children: [
                      Lottie.asset(
                        "anim/success.json",
                        repeat: false,
                      )
                    ],
                  ),
                ),
              );
            }))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future updateOrderStatus(
      {required int status, required String docId, required context}) {
    CollectionReference bookItem =
        FirebaseFirestore.instance.collection('booking');

    return bookItem
        .doc(docId)
        .update({'status': status})
        .then((value) => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: status == 1
                    ? const Text(
                        'This Booking is Accepted',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: primaryColor),
                      )
                    : const Text(
                        'This Booking is Rejected',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.redAccent),
                      ),
                content: SizedBox(
                  width: 300,
                  height: 300,
                  child: ListView(
                    controller: ScrollController(),
                    children: [
                      status == 1
                          ? Lottie.asset(
                              "anim/success.json",
                              repeat: false,
                            )
                          : Lottie.asset(
                              "anim/reject.json",
                              repeat: false,
                            ),
                    ],
                  ),
                ),
              );
            }))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Stream<List<Cleaner>> getBookCleaners(String id) => FirebaseFirestore
      .instance
      .collection("cleaners")
      .where("current-booking-id", isEqualTo: id)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cleaner.fromJson(doc.data())).toList());

  static Future updateBookCleaner(
      {required String cleanerId,
      required String? bookingId,
      required bool status,
      required context}) {
    CollectionReference updateItem =
        FirebaseFirestore.instance.collection('cleaners');

    return updateItem
        .doc(cleanerId)
        .update({'current-booking-id': bookingId, 'status': status})
        .then((value) => print("Added Success"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
