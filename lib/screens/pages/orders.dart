import 'package:clean_admin/components/constants.dart';
import 'package:clean_admin/models/book.dart';
import 'package:clean_admin/models/cleaner.dart';
import 'package:clean_admin/services/fire_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // Timestamp.fromDate(DateTime.parse(selectDate! + " " + selectTime!)),
  bool defaultMode = true;
  String? sTimeDate;
  String? eTimeDate;
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  TimeOfDay sTime = TimeOfDay(hour: 07, minute: 30);
  TimeOfDay eTime = TimeOfDay(hour: 20, minute: 30);
  @override
  Widget build(BuildContext context) {
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');

    String sHour = sTime.hour.toString().padLeft(2, '0');
    String sMinute = sTime.minute.toString().padLeft(2, '0');
    String eHour = eTime.hour.toString().padLeft(2, '0');
    String eMinute = eTime.minute.toString().padLeft(2, '0');
    sTimeDate = "${date.year}-$month-$day $sHour:$sMinute";
    eTimeDate = "${date.year}-$month-$day $eHour:$eMinute";
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: Container(),
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context, initialTime: sTime);
                          if (newTime == null) return;
                          setState(() {
                            sTime = newTime;
                          });
                        },
                        child: Text(
                          "$sHour:$sMinute",
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: secondaryColor),
                        ),
                      ),
                      const Icon(
                        Icons.access_time_sharp,
                        color: primaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "to",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: secondaryColor),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context, initialTime: eTime);
                          if (newTime == null) return;
                          setState(() {
                            eTime = newTime;
                          });
                        },
                        child: Text(
                          "$eHour:$eMinute",
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: secondaryColor),
                        ),
                      ),
                      const Icon(
                        Icons.access_time_sharp,
                        color: primaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          if (newDate == null) return;
                          setState(() {
                            date = newDate;
                          });
                        },
                        child: Text("${date.year}/$month/$day",
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor)),
                      ),
                      const Icon(
                        Icons.calendar_month,
                        color: primaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            defaultMode = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "Filter",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              bottom: const TabBar(
                  labelColor: primaryColor,
                  indicatorColor: secondaryColor,
                  unselectedLabelColor: Color.fromARGB(110, 158, 158, 158),
                  tabs: [
                    Tab(
                      text: "All",
                    ),
                    Tab(
                      text: "Accept",
                    ),
                    Tab(
                      text: "Reject",
                    ),
                    Tab(
                      text: "Completed",
                    ),
                  ]),
            ),
            body: TabBarView(children: [
              StreamBuilder<List<Book>>(
                stream: FireService.getBooks(
                    sTime: Timestamp.fromDate(DateTime.parse(sTimeDate!)),
                    eTime: Timestamp.fromDate(DateTime.parse(eTimeDate!)),
                    mode: defaultMode),
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
                              return builtService(bookings[index]);
                            },
                          );
                        }
                      }
                  }
                },
              ),
              StreamBuilder<List<Book>>(
                stream: FireService.getAcceptBooks(),
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
                              return builtService(bookings[index]);
                            },
                          );
                        }
                      }
                  }
                },
              ),
              StreamBuilder<List<Book>>(
                stream: FireService.getRejectBooks(),
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
                              return builtService(bookings[index]);
                            },
                          );
                        }
                      }
                  }
                },
              ),
              const Center(child: Text("Completed")),
            ])));
  }

  Widget builtService(Book book) {
    String hour = book.date.toDate().hour.toString().padLeft(2, '0');
    String min = book.date.toDate().minute.toString().padLeft(2, '0');
    String dayTime = (book.date.toDate().hour > 12) ? "P.M" : "A.M";
    String year = book.date.toDate().year.toString();
    String month = book.date.toDate().month.toString().padLeft(2, '0');
    String day = book.date.toDate().day.toString().padLeft(2, '0');
    String time = "$hour:$min";
    String date = "$year-$month-$day";
    double screenWidth = MediaQuery.of(context).size.width * 0.8;
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.025),
      child: InkWell(
        // onTap: () => Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ServiceDetails(
        //               service: service,
        //             ))),
        child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenWidth * 0.01,
            ),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.5), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            width: screenWidth,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Text(
                            maxLines: 2,
                            book.serviceName,
                            style: const TextStyle(
                                fontSize: 32,
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("${book.price}.00 AED",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 32,
                            )),
                        const SizedBox(height: 10),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 300,
                          height: 100,
                          child: StreamBuilder<List<Cleaner>>(
                              stream:
                                  FireService.getBookCleaners(book.bookingId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: SpinKitWave(
                                    color: secondaryColor,
                                    size: 25.0,
                                  ));
                                } else if (!snapshot.hasData) {
                                  return const Center(
                                    child: Text("No"),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }
                                final bookCleaners = snapshot.data!;
                                if (bookCleaners.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      "Please Assign Cleaners!",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  controller: ScrollController(),
                                  itemCount: bookCleaners.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      title:
                                          Text(bookCleaners[index].cleanerName),
                                      trailing: IconButton(
                                          onPressed: () {
                                            FireService.updateBookCleaner(
                                                bookingId: null,
                                                cleanerId: bookCleaners[index]
                                                    .cleanerId,
                                                status: true,
                                                context: context);
                                          },
                                          icon: const Icon(Icons.close,
                                              color: Colors.redAccent)),
                                    );
                                  },
                                );
                              }),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Assign Cleaner',
                                      style: TextStyle(color: primaryColor),
                                    ),
                                    content: setupAlertDialoadContainer(
                                        context, book.bookingId),
                                  );
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: const [
                                Text("Assign Cleaners"),
                                Icon(Icons.add_box_outlined)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            //If status 0==Pending ,1==Accept ,2== Reject ,3==Complted
                            FireService.updateOrderStatus(
                                status: 1,
                                docId: book.bookingId,
                                context: context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Row(
                              children: const [
                                Text(
                                  "Accept",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.check_circle_outline_outlined,
                                  color: Colors.white,
                                )
                              ],
                            )),
                          ),
                        ),
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: () {
                            //If status 0==Pending ,1==Accept ,2== Reject ,3==Complted
                            FireService.updateOrderStatus(
                                status: 2,
                                docId: book.bookingId,
                                context: context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Row(
                              children: const [
                                Text(
                                  "Reject",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.white,
                                )
                              ],
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.bed,
                      color: primaryColor,
                    ),
                    Text(
                      book.beds.toString(),
                      style:
                          const TextStyle(color: secondaryColor, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Icon(Icons.timelapse_rounded, color: primaryColor),
                    Text(
                      "${book.hours} hrs",
                      style:
                          const TextStyle(color: secondaryColor, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Icon(Icons.people, color: primaryColor),
                    Text(
                      "${book.cleaners}",
                      style:
                          const TextStyle(color: secondaryColor, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Icon(
                      Icons.calendar_month,
                      color: primaryColor,
                    ),
                    Text(
                      date,
                      style:
                          const TextStyle(color: secondaryColor, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Icon(
                      Icons.access_time_rounded,
                      color: primaryColor,
                    ),
                    Text(
                      "$time $dayTime",
                      style:
                          const TextStyle(color: secondaryColor, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  'Customer Details',
                                  style: TextStyle(color: primaryColor),
                                ),
                                content: SizedBox(
                                  width: 300,
                                  height: 300,
                                  child: ListView(
                                    controller: ScrollController(),
                                    children: [
                                      const ListTile(
                                        title: Text("Date"),
                                        subtitle: Text("2022-07-08"),
                                      ),
                                      const ListTile(
                                        title: Text("Name"),
                                        subtitle: Text("Oshan Mihiraj"),
                                      ),
                                      const ListTile(
                                        title: Text("Address"),
                                        subtitle: Text("No 87, Vales Road"),
                                      ),
                                      const ListTile(
                                        title: Text("Mobile No"),
                                        subtitle: Text("026 773 8627"),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: const [
                            Text("Customer Details"),
                            Icon(Icons.person_pin_circle_outlined)
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget setupAlertDialoadContainer(context, String bookId) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 300.0,
          width: 300.0,
          child: StreamBuilder<List<Cleaner>>(
              stream: FireService.getOnlineCleaners(),
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
                        final cleaner = snapshot.data!;
                        return ListView.builder(
                          controller: ScrollController(),
                          itemCount: cleaner.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                tileColor: bgColor,
                                leading: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: cleaner[index].status != null &&
                                            cleaner[index].status == true
                                        ? Colors.green
                                        : Colors.redAccent,
                                  ),
                                ),
                                title: Text(cleaner[index].cleanerName),
                                subtitle: Text(cleaner[index].serviceName),
                                trailing: IconButton(
                                    onPressed: () {
                                      FireService.updateBookCleaner(
                                          bookingId: bookId,
                                          cleanerId: cleaner[index].cleanerId,
                                          status: false,
                                          context: context);
                                    },
                                    icon: const Icon(Icons.add_box_outlined)),
                              ),
                            );
                          },
                        );
                      }
                    }
                }
              }),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        )
      ],
    );
  }
}
