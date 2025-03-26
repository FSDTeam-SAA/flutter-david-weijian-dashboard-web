import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:david_weijian_dashboard/controller/content_controller.dart';
import 'package:david_weijian_dashboard/presentation/widgets/text_field_widget.dart';

class AddTestCentreForm extends StatelessWidget {
  final ContentController controller;
  
  const AddTestCentreForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: Get.width * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.isEditing.value ? 'Edit Route' : 'Add Test Center',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  if (controller.testCentreId.isEmpty) ...[
                    const SizedBox(height: 10),
                    CustomTextField(
                      label: 'Test Centre Name',
                      onChanged: (value) => controller.testCentreName.value = value,
                      initialValue: controller.testCentreName.value,
                      setInitialValueOnlyOnce: true,
                    ),
                    CustomTextField(
                      label: 'Address',
                      onChanged: (value) => controller.testCentreAddress.value = value,
                      initialValue: controller.testCentreAddress.value,
                      setInitialValueOnlyOnce: true,
                    ),
                    CustomTextField(
                      label: 'Post Code',
                      onChanged: (value) => controller.postCode.value = value,
                      initialValue: controller.postCode.value,
                      setInitialValueOnlyOnce: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.isLoading.value ? null : controller.addTestCentre,
                      child: const Text('Add Test Center'),
                    ),
                  ] else ...[
                    Text(
                      'Test Center: ${controller.testCentreName.value}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Route Information',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      label: 'Route Name',
                      onChanged: (value) => controller.routeName.value = value,
                      initialValue: controller.routeName.value,
                      setInitialValueOnlyOnce: true,
                    ),
                    CustomTextField(
                      label: 'Share URL',
                      onChanged: (value) => controller.shareUrl.value = value,
                      initialValue: controller.shareUrl.value,
                      setInitialValueOnlyOnce: true,
                    ),
                    CustomTextField(
                      label: 'Address',
                      onChanged: (value) => controller.address.value = value,
                      initialValue: controller.address.value,
                      setInitialValueOnlyOnce: true,
                    ),
                    const SizedBox(height: 20),
                    if (!controller.isEditing.value)
                      ElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.pickAndParseGPXFile,
                        child: const Text('Pick GPX File'),
                      ),
                    Obx(
                      () => controller.fileName.isNotEmpty
                          ? Text(
                              'Picked File: ${controller.fileName.value}',
                              style: const TextStyle(fontSize: 16, color: Colors.blue),
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.from.isNotEmpty)
                            Text('From: ${controller.from.value}'),
                          if (controller.to.isNotEmpty)
                            Text('To: ${controller.to.value}'),
                          if (controller.expectedTime.value > 0)
                            Text(
                              'Expected Time: ${controller.expectedTime.value} minutes',
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.isEditing.value
                              ? controller.updateTestCentre
                              : controller.createRoute,
                      child: Text(
                        controller.isEditing.value ? 'Update Route' : 'Create Route',
                      ),
                    ),
                    if (controller.isEditing.value)
                      TextButton(
                        onPressed: () {
                          controller.isEditing.value = false;
                          controller.resetRouteForm();
                        },
                        child: const Text('Cancel'),
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}