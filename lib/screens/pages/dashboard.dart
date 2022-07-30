import 'dart:ui';

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
                    comp('Orders', 'img/img_5.png', 10),
                    comp('Total Income', 'img/img_5.png', 12),
                    comp('Profit', 'img/img_5.png', 24),
                  ],
                ),
              ],
            );
          },
        ));
  }
}

comp(var title, var icon, var count) {
  return Padding(
    padding: const EdgeInsets.only(left: 31.0, top: 40.0, right: 4.0),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 15),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                      fontSize: 65,
                      fontWeight: FontWeight.w700,
                      color: primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70, top: 15),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(icon),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
