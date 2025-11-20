import 'package:ai_chat_app/feature/auth/presentation/pages/signin_page.dart';
import 'package:ai_chat_app/feature/auth/presentation/provider/signup/signup_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/auth_options.dart';
import '../../../../core/widgets/custom_back_botton.dart';
import '../../../../core/widgets/custom_text_field.dart';

class SignupPage extends ConsumerStatefulWidget {
  static const routeName = 'signUp';
  static const routeSettings = '/signup';
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
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
    print(
      'Signup attempt: ${_emailController.text}, ${_passwordController.text}, ${_nameController.text}',
    );
    FocusManager.instance.primaryFocus!.unfocus();

    final form = _formkey.currentState;

    if (form == null || !form.validate()) return;

    ref
        .read(signupProvider.notifier)
        .signup(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          name: _nameController.text.trim(),
        );
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signupProvider, (previous, next) {
      next.when(
        data: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created successfully!')),
          );
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
        loading: () {},
      );
    });

    final signupState = ref.watch(signupProvider);

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
                      child:
                          signupState.isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Register'),
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
