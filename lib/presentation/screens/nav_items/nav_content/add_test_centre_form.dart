import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:david_weijian_dashboard/controller/content_controller.dart';
import 'package:david_weijian_dashboard/presentation/widgets/text_field_widget.dart';

class AddTestCentreForm extends StatelessWidget {
  final ContentController controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddTestCentreForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: Get.width * 0.5,
        child: Form(
          key: _formKey,
          child: Obx(() {
            final isEditing = controller.isEditing.value;
            final isRouteMode = controller.routeId.isNotEmpty || controller.addNewRoute.value;
            final isTestCentreMode = !isRouteMode;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  isEditing
                      ? (isRouteMode ? 'Edit Route' : 'Edit Test Centre')
                      : (isRouteMode ? 'Add Route' : 'Add Test Center'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Only show route fields when in route mode
                if (isRouteMode) ...[
                  Text(
                    'Test Center: ${controller.testCentreName.value}',
                    style: const TextStyle(fontSize: 16),),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Route Name',
                    onChanged: (value) => controller.routeName.value = value,
                    initialValue: controller.routeName.value,
                    validator: (value) => value?.isEmpty ?? true ? 'Required field' : null,
                  ),
                  CustomTextField(
                    label: 'Share URL',
                    onChanged: (value) => controller.shareUrl.value = value,
                    initialValue: controller.shareUrl.value,
                    validator: (value) => value?.isEmpty ?? true ? 'Required field' : null,
                  ),
                  CustomTextField(
                    label: 'Address',
                    onChanged: (value) => controller.address.value = value,
                    initialValue: controller.address.value,
                    validator: (value) => value?.isEmpty ?? true ? 'Required field' : null,
                  ),
                  const SizedBox(height: 20),
                  
                  if (!isEditing) ...[
                    ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.pickAndParseGPXFile,
                      child: const Text('Pick GPX File'),
                    ),
                    const SizedBox(height: 10),
                    Obx(() => controller.fileName.isNotEmpty
                        ? Text(
                            'Picked File: ${controller.fileName.value}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          )
                        : const SizedBox()),
                    const SizedBox(height: 20),
                  ],
                  
                  Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.from.isNotEmpty)
                        Text('From: ${controller.from.value}'),
                      if (controller.to.isNotEmpty)
                        Text('To: ${controller.to.value}'),
                      if (controller.expectedTime.value > 0)
                        Text('Expected Time: ${controller.expectedTime.value} minutes'),
                    ],
                  )),
                  const SizedBox(height: 20),
                ],

                // Only show test centre fields when in test centre mode
                if (isTestCentreMode) ...[
                  CustomTextField(
                    label: 'Test Centre Name',
                    onChanged: (value) => controller.testCentreName.value = value,
                    initialValue: controller.testCentreName.value,
                    validator: (value) => value?.isEmpty ?? true ? 'Required field' : null,
                  ),
                  CustomTextField(
                    label: 'Address',
                    onChanged: (value) => controller.testCentreAddress.value = value,
                    initialValue: controller.testCentreAddress.value,
                    validator: (value) => value?.isEmpty ?? true ? 'Required field' : null,
                  ),
                  CustomTextField(
                    label: 'Post Code',
                    onChanged: (value) => controller.postCode.value = value,
                    initialValue: controller.postCode.value,
                    validator: (value) => value?.isEmpty ?? true ? 'Required field' : null,
                  ),
                  const SizedBox(height: 20),
                ],

                // Action Buttons
                ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            if (isRouteMode) {
                              isEditing
                                  ? await controller.updateRoute()
                                  : await controller.createRoute();
                            } else {
                              isEditing
                                  ? await controller.updateTestCentre()
                                  : await controller.addTestCentre();
                            }
                          }
                        },
                  child: Text(
                    isEditing
                        ? (isRouteMode ? 'Update Route' : 'Update Test Centre')
                        : (isRouteMode ? 'Create Route' : 'Add Test Center'),
                  ),
                ),
                
                if (isEditing) ...[
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      controller.isEditing.value = false;
                      isRouteMode
                          ? controller.resetRouteForm()
                          : controller.resetTestCentreForm();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ],
            );
          }),
        ),
      ),
    );
  }
}