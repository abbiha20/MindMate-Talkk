import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController appointmentDateController = TextEditingController();
  bool booked = false;
  User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Psychologist Appointment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Your Name"),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Your Age"),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: appointmentDateController,
              decoration: const InputDecoration(labelText: "Appointment Date"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await db.collection('appointments').add({
                  'name': nameController.text,
                  'age': ageController.text,
                  'appointmentDate': appointmentDateController.text,
                  'booked': booked,
                });
                setState(() {
                  booked = !booked;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Appointment Booked"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: booked == false
                  ? const Text("Book Appointment")
                  : const Text("Appointment Booked"),
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: db.collection('appointments').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, int index) {
                        DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];
                        return ListTile(
                          title: Text(documentSnapshot['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Age: ${documentSnapshot['age']}"),
                              Text("Appointment Date: ${documentSnapshot['appointmentDate']}"),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              db
                                  .collection('appointments')
                                  .doc(documentSnapshot.id)
                                  .delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Appointment Cancelled"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                            icon: const Icon(Icons.cancel),
                          ),
                          leading: ElevatedButton(
                            onPressed: () async {
                              DateTime? newAppointmentDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              if (newAppointmentDate != null) {
                                String formattedDate = newAppointmentDate.toLocal().toString();
                                db
                                    .collection('appointments')
                                    .doc(documentSnapshot.id)
                                    .update({
                                  'appointmentDate': formattedDate,
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Appointment Date Updated"),
                                    backgroundColor: Colors.amber,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: documentSnapshot['booked'] != false
                                ? const Text("Book Appointment")
                                : const Text("Appointment Booked"),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
