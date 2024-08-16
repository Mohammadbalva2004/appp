import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

final databaseReference = FirebaseDatabase.instance.ref("StoreData");

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController messagesController = TextEditingController();

  List<Map<String, String>> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30),
          child: Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3, color: Colors.black),
                color: Colors.grey[500]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.black)),
                    child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: " Full Name",
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Enter Full Name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            prefixIcon: const Icon(Icons.person),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                )))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.black)),
                    child: TextField(
                        controller: messagesController,
                        decoration: InputDecoration(
                            hintText: "Enter Messages",
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Messages",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            prefixIcon: const Icon(Icons.message),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                )))),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    String id = DateTime.now().microsecond.toString();

                    String name = nameController.text.toString();
                    String messages = messagesController.text.toString();

                    databaseReference.child(id).set({
                      'name': name,
                      'messages': messages,
                    });

                    // setState(() {
                    //   data.add({'name': name, 'messages': messages});
                    //
                    //   nameController.clear();
                    //   messagesController.clear();
                    // });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: const Center(
                        child: Text("ADD",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 50),
        Column(
          children: [
            Table(
              defaultColumnWidth: const FixedColumnWidth(180.0),
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
              children: [
                const TableRow(children: [
                  Column(children: [
                    Text('Full Name', style: TextStyle(fontSize: 20.0))
                  ]),
                  Column(children: [
                    Text('Message', style: TextStyle(fontSize: 20.0))
                  ]),
                ]),
                ...data.map((entry) {
                  return TableRow(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Text(
                              entry['name'] ?? '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Text(
                              entry['message'] ?? '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
