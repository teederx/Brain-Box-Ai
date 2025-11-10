import 'package:ai_chat_app/feature/signin/presentation/signin_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/validators.dart';
import '../../../core/widgets/auth_options.dart';
import '../../../core/widgets/custom_back_botton.dart';
import '../../../core/widgets/custom_text_field.dart';

class SignupPage extends StatefulWidget {
  static const routeName = 'signUp';
  static const routeSettings = '/signup';
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;
  bool _obscureText = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void submit() {
    FocusManager.instance.primaryFocus!.unfocus();

    final form = _formkey.currentState;

    if (form == null || !form.validate()) return;
    /* ref.read(signinProvider.notifier).signin(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ); */
    debugPrint(
      'Name: ${_nameController.text}\nEmail: ${_emailController.text}\nPassword: ${_passwordController.text}',
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            child: Form(
              key: _formkey,
              autovalidateMode: _autovalidateMode,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Back navigation button aligned to the left
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomBackBotton(),
                    ),
                    70.verticalSpace,

                    // Sign up page heading text
                    Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    40.verticalSpace,

                    // Full name input field with validation
                    CustomTextField(
                      controller: _nameController,
                      icon: Icon(Icons.person_rounded),
                      hintText: 'Full Name',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => Validators.validateName(value),
                    ),
                    20.verticalSpace,

                    // Email input field with validation
                    CustomTextField(
                      controller: _emailController,
                      icon: Icon(Icons.email_rounded),
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => Validators.validateEmail(value),
                    ),
                    20.verticalSpace,

                    // Password input field with toggle visibility
                    CustomTextField(
                      controller: _passwordController,
                      icon: Icon(Icons.lock_rounded),
                      hintText: 'Enter your Password',
                      obscureText: _obscureText,
                      isPassword: true,
                      textInputAction: TextInputAction.go,
                      onTap: togglePasswordVisibility,
                      validator: (value) => Validators.validatePassword(value),
                    ),

                    10.verticalSpace,
                    // Forgot password button aligned to the right
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          //TODO: Implement forgot password functionality
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),

                    20.verticalSpace,
                    // Register button with rounded corners
                    ElevatedButton(
                      onPressed: submit,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      child: Text('Register'),
                    ),
                    20.verticalSpace,

                    // Sign in text with clickable link
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    context.pushReplacementNamed(
                                      SigninPage.routeName,
                                    );
                                  },
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,

                    // Separator line
                    Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withAlpha(50),
                    ),
                    20.verticalSpace,

                    // Social authentication options
                    AuthOptions(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
