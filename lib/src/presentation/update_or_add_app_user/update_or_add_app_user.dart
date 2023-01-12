import 'package:backoffice/src/application/app_user_service.dart';
import 'package:backoffice/src/application/firestore_service.dart';
import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:backoffice/src/presentation/common_widget/responsive_center.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:backoffice/src/utils/extension_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_sizes.dart';
import '../../data/paths.dart';
import '../../domain/app_user.dart';
import '../common_widget/loading.dart';
import '../common_widget/my_dropdown/title_dropdown.dart';
import '../common_widget/text_field_and_title.dart';
import '../common_widget/text_form_field_widget.dart';

class UpdateOrAddAppUserScreen extends ConsumerStatefulWidget {
  final AppUser? appUser;

  const UpdateOrAddAppUserScreen({Key? key, this.appUser}) : super(key: key);

  @override
  ConsumerState<UpdateOrAddAppUserScreen> createState() =>
      _UpdateSignalScreenState();
}

class _UpdateSignalScreenState extends ConsumerState<UpdateOrAddAppUserScreen> {
  late TextEditingController _fcmTokenController;
  late TextEditingController _platformController;
  late TextEditingController _countryCallingCodeController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late GlobalKey<FormState> _fKey;
  late FocusScopeNode _node;
  late bool _isPremium;
  late bool _isLogged;
  late bool _hasDeletedAccount;
  late bool _isOnline;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();

    _fcmTokenController = TextEditingController();
    _platformController = TextEditingController();
    _countryCallingCodeController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _isLoading = false;

    _fKey = GlobalKey<FormState>();
    _node = FocusScopeNode();
    if (widget.appUser != null) {
      _fcmTokenController.text = widget.appUser!.fcmToken;
      _platformController.text = widget.appUser!.platform;
      _countryCallingCodeController.text = widget.appUser!.countryCallingCode;
      _phoneNumberController.text = widget.appUser!.phoneNumber;
      _emailController.text = widget.appUser!.email;
      _passwordController.text = widget.appUser!.password;
      _firstNameController.text = widget.appUser!.firstName;
      _lastNameController.text = widget.appUser!.lastName;
      _isPremium = widget.appUser!.isPremium;
      _isLogged = widget.appUser!.isLogged;
      _hasDeletedAccount = widget.appUser!.hasDeletedAccount;
      _isOnline = widget.appUser!.isOnline;
    } else {
      _isPremium = false;
      _isLogged = false;
      _hasDeletedAccount = false;
      _isOnline = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appUser != null ? 'Update AppUser' : 'Add AppUser'),
      ),
      body: SingleChildScrollView(
        child: ResponsivePaddingCenter(
          child: Column(
            children: [
              gapH16,
              FocusScope(
                node: _node,
                child: Form(
                  key: _fKey,
                  child: Column(
                    children: [
                      gapH16,
                      TextFieldAndTitle(
                        title: "FCM Token",
                        enabled: true,
                        textEditingController: _fcmTokenController,
                        typeOfTextForm: TypeOfTextForm.any,
                        onEditingComplete: () {
                          _node.nextFocus();
                        },
                      ),
                      gapH16,
                      TextFieldAndTitle(
                        title: "Platform",
                        textEditingController: _platformController,
                        enabled: true,
                        typeOfTextForm: TypeOfTextForm.any,
                        onEditingComplete: () {
                          _node.nextFocus();
                        },
                      ),
                      gapH16,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Is Premium",
                            style: context.theme.textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.4,
                                height: 0.5,
                                color: context.theme.colorScheme.onBackground),
                          ),
                          gapH4,
                          TitleDropdown(
                              initialValue: _isPremium,
                              dropdownList: const {
                                true: "Premium",
                                false: "Not Premium",
                              },
                              callBack: (value) {
                                _isPremium = value;
                              }),
                        ],
                      ),
                      gapH16,
                      TextFieldAndTitle(
                        title: "Country Calling Code",
                        textEditingController: _countryCallingCodeController,
                        typeOfTextForm: TypeOfTextForm.any,
                        onEditingComplete: () {
                          _node.nextFocus();
                        },
                      ),
                      gapH16,
                      TextFieldAndTitle(
                        title: "Phone Number",
                        textEditingController: _phoneNumberController,
                        typeOfTextForm: TypeOfTextForm.number,
                        onEditingComplete: () {
                          _node.nextFocus();
                        },
                      ),
                      gapH16,
                      TextFieldAndTitle(
                        title: "Email",
                        textEditingController: _emailController,
                        typeOfTextForm: TypeOfTextForm.email,
                        onEditingComplete: () {
                          _node.nextFocus();
                        },
                      ),
                      gapH16,
                      TextFieldAndTitle(
                        title: "Password",
                        textEditingController: _passwordController,
                        typeOfTextForm: TypeOfTextForm.password,
                        onEditingComplete: () {
                          _node.nextFocus();
                        },
                      ),
                      gapH16,
                      TextFieldAndTitle(
                        title: "First Name",
                        textEditingController: _firstNameController,
                        typeOfTextForm: TypeOfTextForm.name,
                        onEditingComplete: () {
                          _node.nextFocus();
                        },
                      ),
                      gapH16,
                      TextFieldAndTitle(
                        title: "Last Name",
                        textEditingController: _lastNameController,
                        typeOfTextForm: TypeOfTextForm.name,
                        onEditingComplete: () {
                          _node.nextFocus();
                        },
                      ),
                      gapH16,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Is Logged",
                            style: context.theme.textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.4,
                                height: 0.5,
                                color: context.theme.colorScheme.onBackground),
                          ),
                          gapH4,
                          TitleDropdown(
                              initialValue: _isLogged,
                              dropdownList: const {
                                true: "Logged",
                                false: "Not Logged",
                              },
                              callBack: (value) {
                                _isLogged = value;
                              }),
                        ],
                      ),
                      gapH16,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Has Deleted Account",
                            style: context.theme.textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.4,
                                height: 0.5,
                                color: context.theme.colorScheme.onBackground),
                          ),
                          gapH4,
                          TitleDropdown(
                              initialValue: _hasDeletedAccount,
                              dropdownList: const {
                                true: "Compte supprimé",
                                false: "Compte actif",
                              },
                              callBack: (value) {
                                _hasDeletedAccount = value;
                              }),
                        ],
                      ),
                      gapH16,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Is Online",
                            style: context.theme.textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.4,
                                height: 0.5,
                                color: context.theme.colorScheme.onBackground),
                          ),
                          gapH4,
                          TitleDropdown(
                              initialValue: _isOnline,
                              dropdownList: const {
                                true: "Entrain d'utiliser l'application",
                                false: "N'utilise pas l'application",
                              },
                              callBack: (value) {
                                _isOnline = value;
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              gapH16,
              if (_isLoading)
                const Loading()
              else
                ElevatedButton(
                    onPressed: () async {
                      if (_fKey.currentState!.validate()) {
                        _fKey.currentState!.save();
                        setState(() {
                          _isLoading = true;
                        });

                        final result = await ref
                            .read(appUserServiceProvider)
                            .setAppUser(
                              appUser: AppUser(
                                  id: widget.appUser?.id ??
                                      FirestoreService.instance
                                          .getDocId(path: Paths.appUsers()),
                                  languageCode: "fr",
                                  fcmToken: _fcmTokenController.text.trim(),
                                  platform: _platformController.text.trim(),
                                  countryCallingCode:
                                      _countryCallingCodeController.text.trim(),
                                  phoneNumber:
                                      _phoneNumberController.text.trim(),
                                  isPremium: _isPremium,
                                  isLogged: _isLogged,
                                  hasDeletedAccount: _hasDeletedAccount,
                                  isOnline: _isOnline,
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  firstName: _firstNameController.text.trim(),
                                  lastName: _lastNameController.text.trim(),
                                  createdAt: widget.appUser?.createdAt ??
                                      DateTime.now(),
                                  updatedAt: widget.appUser?.updatedAt ??
                                      DateTime.now()),
                            );
                        setState(() {
                          _isLoading = false;
                        });
                        result.when((success) {
                          context.showSnackBar(widget.appUser != null
                              ? "App User Updated"
                              : "App User Added");
                        },
                            (error) =>
                                context.showSnackBar(error.details.message));
                      }
                    },
                    child: Text(widget.appUser != null ? "Update" : "Add")),
              gapH64,
            ],
          ),
        ),
      ),
    );
  }
}
