import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:david_weijian_dashboard/controller/content_controller.dart';

class TestCentreList extends StatelessWidget {
  final ContentController controller;
  
  const TestCentreList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.testCentres.isEmpty
          ? const Center(child: Text('No test centres found'))
          : LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = (constraints.maxWidth / 300).floor();
                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: controller.testCentres.length,
                  itemBuilder: (context, index) {
                    final testCentre = controller.testCentres[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          controller.getAllRoutes(testCentre.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  testCentre.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Flexible(
                                child: Text(
                                  testCentre.address,
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Flexible(
                                child: Text(
                                  testCentre.postCode,
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}