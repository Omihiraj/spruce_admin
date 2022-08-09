import 'package:clean_admin/components/constants.dart';
import 'package:clean_admin/controller/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          leading: Container(),
          title: const Text(
            "Dashboard",
            style: TextStyle(
                color: secondaryColor,
                fontSize: headlineText,
                fontWeight: FontWeight.w600),
          ),
          elevation: 0,
          backgroundColor: bgColor,
        ),
        body: Consumer<PageModel>(
          builder: (context, no, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Row(
                    children: [
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
                        child: Container(
                          decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "Check Summary",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text("${date.year}/$month/$day",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    compOrder('Orders', 'img/img_5.png', 10, context),
                    comp('Daily Income', 'img/img_5.png', 120, context),
                    comp('Monthly Income', 'img/img_5.png', 2400, context),
                  ],
                ),
              ],
            );
          },
        ));
  }
}

compOrder(var title, var icon, var count, context) {
  return Padding(
    padding: const EdgeInsets.only(left: 31.0, top: 40.0, right: 4.0),
    child: InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), //color of shadow
              spreadRadius: 7,
              blurRadius: 10,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        height: 160,
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 22.0, left: 30.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, color: Color(0xFF7D7D7D)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30, top: 15, right: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Completed Orders",
                          style: TextStyle(color: primaryColor),
                        ),
                        Text("05")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Active Orders",
                          style: TextStyle(color: primaryColor),
                        ),
                        Text("08")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Rejected Orders",
                          style: TextStyle(color: primaryColor),
                        ),
                        Text("02")
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    ),
  );
}

comp(var title, var icon, var count, context) {
  return Padding(
    padding: const EdgeInsets.only(left: 31.0, top: 40.0, right: 4.0),
    child: InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), //color of shadow
              spreadRadius: 7,
              blurRadius: 10,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        height: 160,
        width: 270,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 22.0, left: 30.0),
              child: Row(
                children: [
                  Text(
                    title,
                    style:
                        const TextStyle(fontSize: 18, color: Color(0xFF7D7D7D)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.description_outlined,
                    color: Colors.amber[200],
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 15),
                  // child: Text(
                  //   "$count.00 AED",
                  //   style: const TextStyle(
                  //       fontSize: 65,
                  //       fontWeight: FontWeight.w700,
                  //       color: primaryColor),
                  // ),
                  child: RichText(
                    text: TextSpan(
                      text: '$count.00',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 52,
                          color: primaryColor),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'AED',
                            style: TextStyle(
                                fontSize: 20, color: Colors.redAccent)),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 70, top: 15),
                //   child: Container(
                //     height: 50,
                //     width: 50,
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage(icon),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
