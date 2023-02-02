import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/students/providers.dart';
import 'package:isar_project/contollers/isar_servise.dart';
import 'package:isar_project/models/student.dart';
import 'package:isar_project/screens/student_screens/student_details.dart';

import '../../constants.dart';
import '../../models/course.dart';

class StudentsScreen extends ConsumerStatefulWidget {
  const StudentsScreen({super.key});

  @override
  ConsumerState<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends ConsumerState<StudentsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    ref.read(studentProvider.notifier).getAllStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listStudents = ref.watch(studentProvider);
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
                              'studentsScreen.title',
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w600,
                                color: kDarkGreenColor,
                              ),
                            ).tr(),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              height: 400,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: listStudents.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: () {
                                        context.push('/studentDetails',
                                            extra: listStudents[index]);
                                      },
                                      focusColor: kFoamColor,
                                      title: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Text(
                                          listStudents[index].name,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                          backgroundColor: kDarkGreenColor,
                                          child: Text('${index + 1}')),
                                    );
                                  }),
                            ),
                            const SizedBox(height: 15.0),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: const Text(
                                      'studentsScreen.addNew',
                                      style: TextStyle(fontSize: 18.0),
                                    ).tr(),
                                  ),
                                  Flexible(
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                kFoamColor),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                kDarkGreenColor),
                                      ),
                                      onPressed: () {
                                        context.push('/addStudent');
                                      },
                                      child: const Text(
                                        'studentsScreen.add',
                                        style: TextStyle(fontSize: 20.0),
                                      ).tr(),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 20.0,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 20.0,
              child: IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                  context.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: kDarkGreenColor,
                  size: 24.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
