import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/courses/providers.dart';
import 'package:isar_project/contollers/isar_servise.dart';
import 'package:isar_project/models/course.dart';

import '../../constants.dart';
import '../auth_screens/validators/validator.dart';
import '../auth_screens/widgets/authentication_button.dart';
import '../auth_screens/widgets/custom_text_field.dart';

class CourseRegisterScreen extends ConsumerWidget {
  CourseRegisterScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  IsarServise course = IsarServise();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseCreditsController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            body: Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.9,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ' COURSE',
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w600,
                                color: kDarkGreenColor,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'register your course',
                              style: TextStyle(
                                color: kGreyColor,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 40.0),
                            CustomTextField(
                              controller: courseNameController,
                              validator: (value) =>
                                  Validators.validateName(value!),
                              hintText: 'course',
                              label: 'Course',
                              icon: Icons.book,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},
                            ),
                            CustomTextField(
                              controller: courseCreditsController,
                              validator: (value) =>
                                  Validators.validateNumber(value!),
                              hintText: 'Credits',
                              label: 'Credits',
                              icon: Icons.biotech,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: AuthenticationButton(
                            label: 'Register',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(createCourseProvider.notifier)
                                    .saveCourse(Course(
                                        couseName: courseNameController.text,
                                        credits: int.parse(
                                            courseCreditsController.text)));

                                context.pop();
                              }
                            },
                          ),
                        )
                      ],
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
}
