import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../controller/login_controller.dart';
import '../input_widget.dart';

class EmailFieldWidget extends StatelessWidget {
  final LoginController loginController;

  const EmailFieldWidget({super.key, required this.loginController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Selector<LoginController, String?>(
      selector: (context, loginController) => loginController.errors['email'],
      builder: (context, errorText, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.email,
              style: GoogleFonts.plusJakartaSans(
                color: theme.textTheme.bodyLarge?.color ?? Color(0xFF6C7278),
                fontWeight: FontWeight.w700,
              ),
            ),
            InputWidget(
              backgroundColor: theme.scaffoldBackgroundColor,
              borderColor: theme.dividerColor,
              textEditingController: loginController.emailController,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              hintText: "demo@demo.com",
              onChanged: (value) => loginController.validateField(
                field: 'email',
                value: value,
                context: context,
              ),
              errorText: errorText,
            ),
          ],
        );
      },
    );
  }
}
