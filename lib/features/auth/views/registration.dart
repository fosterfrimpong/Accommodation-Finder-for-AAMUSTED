import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/views/footer_page.dart';
import 'package:unidwell_finder/utils/colors.dart';

import '../../../config/routes/router.dart';
import '../../../config/routes/router_item.dart';
import '../../../core/views/custom_button.dart';
import '../../../core/views/custom_dialog.dart';
import '../../../core/views/custom_drop_down.dart';
import '../../../core/views/custom_input.dart';
import '../../../utils/styles.dart';
import '../providers/registration_provider.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  bool obsecureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            width: styles.isMobile ? styles.width : 500,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      blurRadius: 10,
                                      spreadRadius: 5)
                                ]),
                            child: () {
                              return buildUserInit();

                              //return buildPatientMetaData();
                            }()))),
              ],
            )),
            const FooterPage(),
          ],
        ));
  }

  Widget buildUserInit() {
    var provider = ref.watch(userRegistrationProvider);
    var notifier = ref.read(userRegistrationProvider.notifier);
    var styles = Styles(context);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('User Registration',
                  style: styles.body(
                      desktop: 22,
                      mobile: 20,
                      tablet: 21,
                      fontWeight: FontWeight.bold,
                      color: primaryColor)),
              const Divider(
                thickness: 2,
                height: 20,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Radio<String>(
                      value: 'student',
                      activeColor: primaryColor,
                      groupValue: provider.role,

                      // fillColor: WidgetStateProperty.all(
                      //     primaryColor),
                      onChanged: (value) {
                        notifier.setUserRole(value);
                      }),
                  const Text('I am a Student'),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Radio<String>(
                      value: 'manager',
                      activeColor: primaryColor,
                      groupValue: provider.role,
                      onChanged: (value) {
                        notifier.setUserRole(value);
                      }),
                  const Text('I am a Hostel Manager'),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextFields(
                label: 'Full Name',
                prefixIcon: Icons.person,
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onSaved: (name) {
                  notifier.setName(name!);
                },
              ),
              const SizedBox(height: 20),
              CustomDropDown(
                  items: ['Male', 'Female']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  label: 'Gender',
                  prefixIcon: Icons.male,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'User gender is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    notifier.setGender(value);
                  }),
              const SizedBox(height: 20),
              CustomTextFields(
                label: 'Email',
                prefixIcon: Icons.email,
                onSaved: (email) {
                  notifier.setEmail(email!);
                },
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(email)) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              if (provider.role != 'manager') const SizedBox(height: 20),
              if (provider.role != 'manager')
                CustomDropDown(
                    items: [
                      'AAMUSTED',
                      'KNUST',
                      'UCC',
                      'UG',
                      'UENR',
                      'UDS',
                      'UMaT',
                      'UHAS',
                      'UEW',
                      'KsTU',
                      'KTU',
                      'HTU',
                      'GTUC',
                      'GIMPA'
                    ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    label: 'Institution',
                    prefixIcon: Icons.school,
                    onChanged: (value) => notifier.setInstitution(value),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Institution is required'
                        : null),
              const SizedBox(height: 20),
              CustomTextFields(
                label: 'Phone Number',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                isDigitOnly: true,
                validator: (phone) {
                  if (phone == null || phone.isEmpty) {
                    return 'Phone number is required';
                  } else if (phone.length != 10) {
                    return 'Phone number must be exactly 10 characters';
                  }
                  return null;
                },
                onSaved: (phone) {
                  notifier.setPhone(phone!);
                },
              ),
              const SizedBox(height: 20),
              CustomTextFields(
                label: 'Password',
                prefixIcon: Icons.lock,
                obscureText: obsecureText,
                suffixIcon: IconButton(
                    icon: Icon(
                        obsecureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        obsecureText = !obsecureText;
                      });
                    }),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Password is required';
                  } else if (password.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (password) {
                  notifier.setPassword(password!);
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (provider.role.isEmpty) {
                      CustomDialogs.toast(
                        message: 'Select user role',
                        type: DialogType.error,
                      );
                    } else {
                      _formKey.currentState!.save();
                      notifier.createNewUser(ref: ref, context: context);
                    }
                  }
                },
                radius: 5,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                      onPressed: () {
                        MyRouter(ref: ref, context: context)
                            .navigateToRoute(RouterItem.loginRoute);
                      },
                      child: const Text('Login'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
