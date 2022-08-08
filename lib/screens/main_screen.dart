import 'package:clean_admin/components/constants.dart';
import 'package:clean_admin/controller/page_controller.dart';
import 'package:clean_admin/screens/pages/Services.dart';
import 'package:clean_admin/screens/pages/add_service.dart';
import 'package:clean_admin/screens/pages/cleaners.dart';
import 'package:clean_admin/screens/pages/dashboard.dart';

import 'package:clean_admin/screens/pages/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  var pages = [
    const Dashboard(),
    const Orders(),
    const Cleaners(),
    const Services(),
    const AddService(),
  ];
  final pageNo = PageModel();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: SafeArea(
              child: Row(
        children: [
          Expanded(
            child: Drawer(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Image.asset("img/logo.png"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.home_filled,
                        color: Provider.of<PageModel>(context).getPageNo == 0
                            ? Colors.white
                            : secondaryColor,
                      ),
                      tileColor: Provider.of<PageModel>(context).getPageNo == 0
                          ? primaryColor
                          : Colors.white,
                      onTap: () {
                        Provider.of<PageModel>(context, listen: false)
                            .currentPage(0);
                      },
                      horizontalTitleGap: 0,
                      title: Text(
                        "Dashboard",
                        style: TextStyle(
                          color: Provider.of<PageModel>(context).getPageNo == 0
                              ? Colors.white
                              : secondaryColor,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.list_alt_rounded,
                        color: Provider.of<PageModel>(context).getPageNo == 1
                            ? Colors.white
                            : secondaryColor,
                      ),
                      tileColor: Provider.of<PageModel>(context).getPageNo == 1
                          ? primaryColor
                          : Colors.white,
                      onTap: () {
                        Provider.of<PageModel>(context, listen: false)
                            .currentPage(1);
                      },
                      horizontalTitleGap: 0,
                      title: Text(
                        "Orders",
                        style: TextStyle(
                          color: Provider.of<PageModel>(context).getPageNo == 1
                              ? Colors.white
                              : secondaryColor,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.people,
                        color: Provider.of<PageModel>(context).getPageNo == 2
                            ? Colors.white
                            : secondaryColor,
                      ),
                      tileColor: Provider.of<PageModel>(context).getPageNo == 2
                          ? primaryColor
                          : Colors.white,
                      onTap: () {
                        Provider.of<PageModel>(context, listen: false)
                            .currentPage(2);
                      },
                      horizontalTitleGap: 0,
                      title: Text(
                        "Cleaners",
                        style: TextStyle(
                          color: Provider.of<PageModel>(context).getPageNo == 2
                              ? Colors.white
                              : secondaryColor,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.cleaning_services,
                        color: Provider.of<PageModel>(context).getPageNo == 3
                            ? Colors.white
                            : secondaryColor,
                      ),
                      tileColor: Provider.of<PageModel>(context).getPageNo == 3
                          ? primaryColor
                          : Colors.white,
                      onTap: () {
                        Provider.of<PageModel>(context, listen: false)
                            .currentPage(3);
                      },
                      horizontalTitleGap: 0,
                      title: Text(
                        "Services",
                        style: TextStyle(
                          color: Provider.of<PageModel>(context).getPageNo == 3
                              ? Colors.white
                              : secondaryColor,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: secondaryColor,
                      ),
                      tileColor: Colors.white,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      horizontalTitleGap: 0,
                      title: const Text(
                        "Logout",
                        style: TextStyle(
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 5, child: pages[Provider.of<PageModel>(context).getPageNo])
        ],
      ))),
    );
  }
}
