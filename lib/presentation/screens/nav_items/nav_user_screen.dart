import 'package:david_weijian_dashboard/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavUserScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  NavUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              userController.fetchUserData();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (userController.userData.isEmpty) {
          return const Center(child: Text('No user data found'));
        } else {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    scrollDirection: Axis.vertical,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                      ),
                      child: DataTable(
                        columnSpacing: 24,
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Email',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Role',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Date of Birth',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Created At',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Updated At',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows:
                            userController.userData.asMap().entries.map((
                              entry,
                            ) {
                              return DataRow(
                                color: WidgetStateProperty.resolveWith<Color?>((
                                  states,
                                ) {
                                  return entry.key.isEven
                                      ? Colors.grey[200]
                                      : Colors.white;
                                }),
                                cells: [
                                  DataCell(
                                    Text(entry.value.name),
                                    onTap: () {
                                      print('Clicked on ${entry.value.name}');
                                    },
                                  ),
                                  DataCell(
                                    Text(entry.value.email),
                                    onTap: () {
                                      print('Clicked on ${entry.value.email}');
                                    },
                                  ),
                                  DataCell(
                                    Text(entry.value.role),
                                    onTap: () {
                                      print('Clicked on ${entry.value.role}');
                                    },
                                  ),
                                  DataCell(
                                    Text(entry.value.dateOfBirth.toString()),
                                    onTap: () {
                                      print(
                                        'Clicked on ${entry.value.dateOfBirth}',
                                      );
                                    },
                                  ),
                                  DataCell(
                                    Text(entry.value.createdAt.toString()),
                                    onTap: () {
                                      print(
                                        'Clicked on ${entry.value.createdAt}',
                                      );
                                    },
                                  ),
                                  DataCell(
                                    Text(entry.value.updatedAt.toString()),
                                    onTap: () {
                                      print(
                                        'Clicked on ${entry.value.updatedAt}',
                                      );
                                    },
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
