import 'package:clean_admin/components/constants.dart';
import 'package:clean_admin/models/book.dart';
import 'package:clean_admin/services/fire_services.dart';

import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: Container(),
              backgroundColor: Colors.white,
              elevation: 0,
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
                stream: FireService.getBooks(),
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
            child: Row(
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
                    Text("\$ ${book.price}.00",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.bed,
                          color: primaryColor,
                        ),
                        Text(
                          book.beds.toString(),
                          style: const TextStyle(
                              color: secondaryColor, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        const Icon(Icons.timelapse_rounded,
                            color: primaryColor),
                        Text(
                          "${book.hours} hrs",
                          style: const TextStyle(
                              color: secondaryColor, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        const Icon(Icons.people, color: primaryColor),
                        Text(
                          "${book.cleaners}",
                          style: const TextStyle(
                              color: secondaryColor, fontSize: 20),
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
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: ListView.builder(
                        controller: ScrollController(),
                        itemCount: 15,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Cleaner $index'),
                            trailing: const Icon(Icons.add_box_outlined),
                          );
                        },
                      ),
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
                                content: setupAlertDialoadContainer(context),
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: const [
                            Text("Assign Cleaners"),
                            Icon(Icons.add_box),
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
                            status: 1, docId: book.bookingId, context: context);
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
                            status: 2, docId: book.bookingId, context: context);
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
            )),
      ),
    );
  }

  Widget setupAlertDialoadContainer(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 300.0,
          width: 300.0,
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Cleaner $index'),
                trailing: const Icon(Icons.add_box_outlined),
              );
            },
          ),
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
