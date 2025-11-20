import 'package:ai_chat_app/core/utils/validators.dart';
import 'package:ai_chat_app/core/widgets/custom_text_field.dart';
import 'package:ai_chat_app/feature/auth/presentation/provider/password_reset/password_reset_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_back_botton.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  static const String routeName = 'forgot-password';
  static const String routeSetting = '/forgot-password';
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _autovalidateMode = AutovalidateMode.onUserInteraction;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void submit() {
    FocusManager.instance.primaryFocus!.unfocus();

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    ref
        .read(passwordResetProvider.notifier)
        .sendResetEmail(email: _emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(passwordResetProvider, (previous, next) {
      next.when(
        data: (data) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Email sent')));
          context.pop();
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
        loading: () {},
      );
    });
    final state = ref.watch(passwordResetProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Back navigation button aligned to the left
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomBackBotton(),
                    ),
                    70.verticalSpace,

                    // Forgot password page heading text
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 45.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      'To continue, we will send a password reset link to the email address entered below',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withAlpha(100),
                      ),
                    ),

                    50.verticalSpace,
                    Card(
                      elevation: 5,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(
                          20.r,
                        ).copyWith(top: 30.r, bottom: 30.r),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          // border: Border.all(),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Type in your email below',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(
                                  context,
                                ).colorScheme.secondary.withAlpha(100),
                              ),
                            ),
                            15.verticalSpace,
                            CustomTextField(
                              controller: _emailController,
                              icon: Icon(Icons.email_rounded),
                              hintText: 'Email',
                              validator:
                                  (value) => Validators.validateEmail(value),
                            ),
                          ],
                        ),
                      ),
                    ),
                    30.verticalSpace,
                    ElevatedButton(
                      onPressed: state.isLoading ? null : submit,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      child:
                          state.isLoading
                              ? Text('Loading...')
                              : Text('Send Verification Code'),
                    ),
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
