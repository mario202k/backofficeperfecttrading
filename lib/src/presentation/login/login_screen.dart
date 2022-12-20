import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:backoffice/src/localization/localized_build_context.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:backoffice/src/utils/extension_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../generated/assets.dart';
import '../../application/auth_service.dart';
import '../../constants/app_sizes.dart';
import '../../routing/app_router.dart';
import '../common_widget/loading.dart';
import '../common_widget/responsive_center.dart';
import '../common_widget/text_field_and_title.dart';
import '../common_widget/text_form_field_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _fKey;
  late FocusScopeNode _node;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _fKey = GlobalKey<FormState>();
    _node = FocusScopeNode();
    _isLoading = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _node.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: SingleChildScrollView(
          child: ResponsivePaddingCenter(
            child: Column(
              children: [
                gapH48,
                Image.asset(
                  Assets.iconsLogo2,
                  height: 80,
                ),
                gapH16,
                FocusScope(
                  node: _node,
                  child: Form(
                    key: _fKey,
                    child: Column(
                      children: [
                        Text(
                          context.loc.adminConsole,
                          style: context.theme.textTheme.headline5,
                        ),
                        gapH16,
                        TextFieldAndTitle(
                          title: context.loc.email,
                          hintText: "john.doe@perfecttrading.com",
                          textEditingController: _emailController,
                          typeOfTextForm: TypeOfTextForm.email,
                          onEditingComplete: () {
                            _node.nextFocus();
                          },
                        ),
                        gapH16,
                        TextFieldAndTitle(
                          title: context.loc.password,
                          textEditingController: _passwordController,
                          typeOfTextForm: TypeOfTextForm.password,
                          onEditingComplete: () {
                            _login();
                          },
                        ),
                        gapH16,
                      ],
                    ),
                  ),
                ),
                gapH16,
                if (_isLoading)
                  const Loading()
                else
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _login();
                          },
                          child: Text(context.loc.login),
                        ),
                      ),
                    ],
                  ),
                gapH30,
              ],
            ),
          ),
        ));
  }

  Future<void> _login() async {
    _node.unfocus();
    if (_fKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final result = await ref
          .read(authServiceProvider)
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }

      result.when((success) {
        if (mounted) {
          context.goNamed(AppRoute.home.name);
        }
      }, (error) {
        if (mounted) {
          context.showSnackBarError(error.details.message);
        }
      });
    }
  }
}
