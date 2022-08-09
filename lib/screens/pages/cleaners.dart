import 'package:clean_admin/components/constants.dart';
import 'package:clean_admin/models/cleaner.dart';
import 'package:clean_admin/services/fire_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Cleaners extends StatefulWidget {
  const Cleaners({Key? key}) : super(key: key);

  @override
  State<Cleaners> createState() => _CleanersState();
}

class _CleanersState extends State<Cleaners> {
  TextEditingController cleanerName = TextEditingController();
  TextEditingController cleanerAddress = TextEditingController();
  TextEditingController cleanerService = TextEditingController();
  TextEditingController cleanerMobile = TextEditingController();
  @override
  void dispose() {
    cleanerName.dispose();
    cleanerAddress.dispose();
    cleanerService.dispose();
    cleanerMobile.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          leading: Container(),
          title: const Text(
            "Cleaners",
            style: TextStyle(
                color: secondaryColor,
                fontSize: headlineText,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 50),
              child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Add Cleaner',
                              style: TextStyle(color: primaryColor),
                            ),
                            content: SizedBox(
                              width: 300,
                              height: 300,
                              child: ListView(
                                controller: ScrollController(),
                                children: [
                                  TextField(
                                    controller: cleanerName,
                                    decoration: InputDecoration(
                                        label: const Text("Cleaner Name"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    controller: cleanerService,
                                    decoration: InputDecoration(
                                        label: const Text("Service Name"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    controller: cleanerAddress,
                                    decoration: InputDecoration(
                                        label: const Text("Address"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    controller: cleanerMobile,
                                    decoration: InputDecoration(
                                        label: const Text("Mobile No"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () {
                                        FireService.addCleaner(
                                            context: context,
                                            cleanerName:
                                                cleanerName.text.trim(),
                                            serviceName:
                                                cleanerService.text.trim(),
                                            cleanerAddress:
                                                cleanerAddress.text.trim(),
                                            cleanerMobile:
                                                cleanerMobile.text.trim());
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Submit"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          Text("Add Cleaner",
                              style: TextStyle(color: Colors.white)),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.add_circle_outline_rounded,
                              color: Colors.white)
                        ],
                      ))),
            ),
          ],
          elevation: 0,
          backgroundColor: bgColor,
        ),
        body: StreamBuilder<List<Cleaner>>(
            stream: FireService.getCleaners(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    if (snapshot.data == null) {
                      return const Text('No data to show');
                    } else {
                      final bookings = snapshot.data!;

                      return ListView.builder(
                        controller: ScrollController(),
                        itemCount: bookings.length,
                        itemBuilder: (BuildContext context, int index) {
                          final cleaner = snapshot.data![index];
                          return CleanerItem(
                            name: cleaner.cleanerName,
                            address: cleaner.cleanerAddress,
                            service: cleaner.serviceName,
                            mobileNo: cleaner.cleanerMobile,
                            status: cleaner.status!,
                            feedback: cleaner.feedback!,
                          );
                        },
                      );
                    }
                  }
              }
            }));
  }
}

class CleanerItem extends StatelessWidget {
  final String name;
  final String address;
  final String mobileNo;
  final String service;
  final bool status;
  final double feedback;
  const CleanerItem({
    required this.name,
    required this.address,
    required this.service,
    required this.mobileNo,
    required this.status,
    required this.feedback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(10.0, 10.0), //(x,y)
            blurRadius: 6.0,
          ),
        ], borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "($service)",
                  style: const TextStyle(
                    color: secondaryColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RatingBar.builder(
                  initialRating: feedback,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  ignoreGestures: true,
                  itemPadding: const EdgeInsets.only(right: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(address),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: secondaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(mobileNo),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: status ? Colors.green : Colors.redAccent,
                      borderRadius: BorderRadius.circular(50)),
                  child: status
                      ? const Text(
                          "Available",
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          "Not Available",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
