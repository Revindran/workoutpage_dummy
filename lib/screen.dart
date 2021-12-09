import 'package:flutter/material.dart';

import 'draggable_list.dart';
import 'list_data.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

bool editable = false;
bool warmUp = false;
bool cDown = false;
bool drill = false;
enum SingingCharacter { lafayette, jefferson }

late DraggableList drillList;
late DraggableList cdList;
late DraggableList wpList;

class _MainScreenState extends State<MainScreen> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  void initState() {
    super.initState();
    drillList = drillData;
    cdList = cdData;
    wpList = warmUpData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade900,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "Workout 1",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  icon: const Icon(
                    Icons.share_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                  onPressed: () {}),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.alarm,
                color: Colors.black,
                size: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.bookmark_outline, color: Color(0xff233a74)),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff233a74)),
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        editable = !editable;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: editable
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12)
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
              child: Column(
                children: [
                  productsCard(drillList),
                  productsCard(wpList),
                  productsCard(cdList),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void rebuildScreen() {
    setState(() {});
  }

  void addProduct(
    DraggableList list,
    DraggableListItem item,
  ) {
    editable
        ? {
            print("Adding"),
            setState(() {
              list.items.add(item);
            }),
            rebuildScreen(),
          }
        : print("Non Editable");
  }

  void removeProduct(
    DraggableList list,
    DraggableListItem item,
  ) {
    editable
        ? {
            print("Removing"),
            setState(() {
              list.items.remove(item);
            }),
            rebuildScreen(),
          }
        : print("Non Editable");
  }

  Widget productsCard(DraggableList list) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(list.header),
          SizedBox(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.items.length,
              itemBuilder: (BuildContext context, int i) => Card(
                child: SizedBox(
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      editable
                          ? showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialogs(context, list.header, list,
                                      list.items[i]),
                            )
                          : ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                              content:
                                  Text("Please Enable Editing Option First"),
                            ));
                    },
                    child: Image.network(
                      list.items[i].urlImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupDialogs(
      BuildContext context, title, DraggableList list, DraggableListItem item) {
    String titles = title;
    bool showerror = false;
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          elevation: 0.0,
          // title: Center(child: Text("Evaluation our APP")),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(13.0))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "${title}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      if (showerror)
                        const Text(
                          "Please assign a Type",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            titles = "Warmup";
                            showerror = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffe6e6e6),
                              borderRadius: BorderRadius.circular(8.5),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text("Warmup",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff282828))),
                                  ),
                                  IconTheme(
                                    data:
                                        new IconThemeData(color: Colors.yellow),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 75.0),
                                      child: titles == "Warmup"
                                          ? const Icon(
                                              Icons.check_circle_rounded,
                                              color: Color(0xff76b0ff))
                                          : Container(),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            titles = "Drill";
                            showerror = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffe6e6e6),
                              borderRadius: BorderRadius.circular(8.5),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text("Drill",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff282828))),
                                  ),
                                  IconTheme(
                                    data:
                                        new IconThemeData(color: Colors.yellow),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 75.0),
                                      child: titles == "Drill"
                                          ? Icon(Icons.check_circle_rounded,
                                              color: Color(0xff76b0ff))
                                          : Container(),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            titles = "Cool down";
                            showerror = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffe6e6e6),
                              borderRadius: BorderRadius.circular(8.5),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 13.0),
                                    child: Text("Cool down",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff282828))),
                                  ),
                                  IconTheme(
                                    data:
                                        new IconThemeData(color: Colors.yellow),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 75.0),
                                      child: titles == "Cool down"
                                          ? const Icon(
                                              Icons.check_circle_rounded,
                                              color: Color(0xff76b0ff))
                                          : Container(),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          removeProduct(list, item);
                          addProduct(getList(titles), item);
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff233a74),
                              borderRadius: BorderRadius.circular(8.5),
                            ),
                            child: const Center(
                              child: Text("Assign / Reorder",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xffffffff))),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          removeProduct(list, item);
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff233a74),
                              borderRadius: BorderRadius.circular(8.5),
                            ),
                            child: const Center(
                              child: Text("Delete Item",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xffffffff))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
            ],
          ));
    });
  }

  DraggableList getList(String titles) {
    return titles == 'Warmup'
        ? wpList
        : titles == 'Cool down'
            ? cdList
            : drillList;
  }

// void showDialog() {
//   showGeneralDialog(
//     barrierLabel: "Barrier",
//     barrierDismissible: true,
//     barrierColor: Colors.black.withOpacity(0.5),
//     transitionDuration: const Duration(milliseconds: 200),
//     context: context,
//     pageBuilder: (_, __, ___) {
//       return Scaffold(
//         body: Container(
//           height: 200,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Text("Best Cross-Platform Mobile App Development Tools for 2021",
//                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
//               ),
//               SizedBox(height: 10,),
//               MyRadioOption<String>(
//                 value: '1',
//                 groupValue: _groupValue,
//                 onChanged: _valueChangedHandler(),
//                 label: '1',
//                 text: 'Phone Gap',
//               ),
//               MyRadioOption<String>(
//                 value: '2',
//                 groupValue: _groupValue,
//                 onChanged: _valueChangedHandler(),
//                 label: '2',
//                 text: 'Appcelerator',
//               ),
//               MyRadioOption<String>(
//                 value: '3',
//                 groupValue: _groupValue,
//                 onChanged: _valueChangedHandler(),
//                 label: '3',
//                 text: 'React Native',
//               ),
//               MyRadioOption<String>(
//                 value: '4',
//                 groupValue: _groupValue,
//                 onChanged: _valueChangedHandler(),
//                 label: '4',
//                 text: 'Native Script',
//               ),
//               MyRadioOption<String>(
//                 value: '5',
//                 groupValue: _groupValue,
//                 onChanged: _valueChangedHandler(),
//                 label: '5',
//                 text: 'Flutter',
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//     transitionBuilder: (_, anim, __, child) {
//       return SlideTransition(
//         position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
//             .animate(anim),
//         child: child,
//       );
//     },
//   );
// }
}
