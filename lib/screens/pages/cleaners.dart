import 'package:clean_admin/components/constants.dart';
import 'package:flutter/material.dart';

class Cleaners extends StatefulWidget {
  const Cleaners({Key? key}) : super(key: key);

  @override
  State<Cleaners> createState() => _CleanersState();
}

class _CleanersState extends State<Cleaners> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
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
        body: ListView(children: const [
          SizedBox(
            height: 20,
          ),
          CleanerItem(
            name: "name",
            address: "address",
            service: "service",
            mobileNo: "mobileNo",
            status: true,
          ),
        ]));
  }
}

class CleanerItem extends StatelessWidget {
  final String name;
  final String address;
  final String mobileNo;
  final String service;
  final bool status;
  const CleanerItem({
    required this.name,
    required this.address,
    required this.service,
    required this.mobileNo,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
