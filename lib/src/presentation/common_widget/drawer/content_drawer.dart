import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:backoffice/src/localization/localized_build_context.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:backoffice/src/utils/extension_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/assets.dart';
import '../../../application/auth_service.dart';
import '../../../constants/app_sizes.dart';
import '../../../routing/app_router.dart';
import '../../../utils/function.dart';
import '../my_dropdown_lang.dart';
import '../responsive_center.dart';

class ContentDrawer extends ConsumerWidget {
  const ContentDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsivePaddingCenter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH48,
          Image.asset(
            Assets.iconsLogo2,
            height: 70,
          ),
          gapH16,
          Row(
            children: [
              Text(
                context.loc.language,
                style: context.theme.textTheme.bodyText1,
              ),
              gapW16,
              const MyDropdownLang(forDrawer: true),
            ],
          ),
          gapH16,
          Text(context.loc.support,
              style: context.theme.textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w900,
              )),
          gapH16,
          InkWell(
            onTap: () {
              myLaunchUrl("https://www.fx.trading-perfect.fr/privacy-policy");
            },
            child: Row(
              children: [
                Image.asset(Assets.iconsShieldDone, width: 24, height: 24),
                gapW8,
                Text(context.loc.privacyPolicy),
              ],
            ),
          ),
          gapH16,
          InkWell(
            onTap: () {
              myLaunchUrl("https://www.fx.trading-perfect.fr/eula");
            },
            child: Row(
              children: [
                Image.asset(Assets.iconsNotice, width: 24, height: 24),
                gapW8,
                Text(context.loc.termsAndConditionsUpper),
              ],
            ),
          ),
          gapH16,
          InkWell(
            onTap: () async {

              final result = await ref
                  .read(authServiceProvider).signOut();

              result.when((success) {
                context.goNamed(AppRoute.login.name);
              }, (failure) {
                context.showSnackBarError(failure.details.message);
              });
            },
            child: Row(
              children: [
                Image.asset(Assets.iconsLogout, width: 24, height: 24),
                gapW8,
                Text(context.loc.logout),
              ],
            ),
          ),
          gapH16,
          InkWell(
            onTap: () async {

              final result = await ref
                  .read(authServiceProvider).deleteAccount();

              result.when((success) {
                print("delete account success");
                context.goNamed(AppRoute.login.name);
              }, (failure) {
                context.showSnackBarError(failure.details.message);
              });
            },
            child: Row(
              children: [
                const Icon(Icons.close, color: Colors.red),
                gapW8,
                Text(context.loc.deleteAccount),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
