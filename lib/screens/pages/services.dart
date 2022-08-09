import 'package:clean_admin/components/constants.dart';
import 'package:clean_admin/controller/page_controller.dart';
import 'package:clean_admin/models/service.dart';
import 'package:clean_admin/services/fire_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: Container(),
        title: const Text(
          "Services",
          style: TextStyle(
              color: secondaryColor,
              fontSize: headlineText,
              fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: bgColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<PageModel>(context, listen: false)
                          .currentPage(4);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add_circle_outline_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add Service",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 500,
              child: StreamBuilder<List<Service>>(
                stream: FireService.getServices(),
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
                          final services = snapshot.data!;

                          return ListView.builder(
                            controller: ScrollController(),
                            itemCount: services.length,
                            itemBuilder: (BuildContext context, int index) {
                              return builtService(services[index]);
                            },
                          );
                        }
                      }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget builtService(Service service) {
    double screenWidth = MediaQuery.of(context).size.width * 0.5;
    return Padding(
      padding: EdgeInsets.only(
          bottom: screenWidth * 0.05,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05),
      child: InkWell(
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(10.0, 10.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            //padding: const EdgeInsets.all(10.0),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ClipRRect(
                //   borderRadius: const BorderRadius.horizontal(
                //       left: Radius.circular(10), right: Radius.circular(25)),
                //   child: Image.network(
                //     fit: BoxFit.cover,
                //     service.img,
                //     width: 100,
                //     height: 100,
                //   ),
                // ),
                Container(
                  width: screenWidth * 0.4,
                  padding: EdgeInsets.only(right: screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: const TextStyle(
                            fontSize: 28,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text("${service.price}/h AED",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ))
                    ],
                  ),
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
                            leading: const Icon(Icons.location_on),
                            title: Text('Location $index'),
                            subtitle: const Text("Price \$10"),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Row(
                          children: const [
                            Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.edit_note_sharp,
                              color: Colors.white,
                            )
                          ],
                        )),
                      ),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Row(
                          children: const [
                            Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.delete_sweep_rounded,
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
}
