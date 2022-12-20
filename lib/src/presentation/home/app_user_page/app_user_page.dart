
import 'dart:html' as html;

import 'package:backoffice/src/constants/app_sizes.dart';
import 'package:backoffice/src/domain/app_user.dart';
import 'package:backoffice/src/presentation/common_widget/async_value_widget.dart';
import 'package:backoffice/src/presentation/common_widget/responsive_center.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../../../data/app_user_repository.dart';
import 'my_dropdown_value.dart';


final allAppUsersProvider =
FutureProvider.autoDispose<List<AppUser>>((ref) async {
  return ref.watch(appUserRepositoryProvider).getAppUsers(date: ref.watch(dateTimeProvider));
});

final allPremiumAppUserProvider =
FutureProvider.autoDispose<List<AppUser>>((ref) async {
  return ref.watch(appUserRepositoryProvider).getPremiumAppUsers(date: ref.watch(dateTimeProvider));
});

final allDeletedAppUserProvider =
FutureProvider.autoDispose<List<AppUser>>((ref) async {
  return ref.watch(appUserRepositoryProvider).getDeletedAppUsers(date: ref.watch(dateTimeProvider));
});

final allOnlineAppUserProvider =
FutureProvider.autoDispose<List<AppUser>>((ref) async {
  return ref.watch(appUserRepositoryProvider).getOnlineAppUsers(date: ref.watch(dateTimeProvider));
});

final allLoggedAppUserProvider =
FutureProvider.autoDispose<List<AppUser>>((ref) async {
  return ref.watch(appUserRepositoryProvider).getLoggedAppUsers(date: ref.watch(dateTimeProvider));
});

final dateTimeProvider = StateProvider.autoDispose<DateTime?>((ref)  {
  return null;
});

class AppUserPage extends ConsumerWidget {
  const AppUserPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<MyDropdownValueEnum, AsyncValue<List<AppUser>>> myValues = {
      MyDropdownValueEnum.all: ref.watch(allAppUsersProvider),
      MyDropdownValueEnum.premium: ref.watch(allPremiumAppUserProvider),
      MyDropdownValueEnum.deleted: ref.watch(allDeletedAppUserProvider),
      MyDropdownValueEnum.online: ref.watch(allOnlineAppUserProvider),
      MyDropdownValueEnum.logged: ref.watch(allLoggedAppUserProvider),
    };
    return ResponsivePaddingCenter(
      child: Column(
        children: [
          gapH30,
          Row(
            mainAxisSize: MainAxisSize.min,
            children:  [
              const Text('Filter:'),
              gapW12,
              const MyDropdownValue(),
              gapW48,
              const Text('Actif since:'),
              gapW12,
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Center(
                  child: WebDatePicker(
                    onChange: (value) {
                      ref.read(dateTimeProvider.notifier).state = value;
                    },
                  ),
                ),
              )
            ],
          ),
          gapH30,
          AsyncValueWidget<List<AppUser>>(
              value: myValues[ref.watch(myValueProvider)]!,
              data: (data) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Table(
                        border: TableBorder.all(
                            width: 1, color: Colors.black.withOpacity(0.4)),
                        children: [
                          const TableRow(children: [
                            Text('email'),
                            Text("first name"),
                            Text("last name"),
                            Text("phone number"),
                            Text('isLogged'),
                            Text('isPremium'),
                          ]),
                          ...data.map((appUser) => TableRow(
                                  children: [
                                Text(appUser.email),
                                Text(appUser.firstName),
                                Text(appUser.lastName),
                                Text(appUser.countryCallingCode +
                                    appUser.phoneNumber),
                                Text(appUser.isLogged.toString()),
                                Text(appUser.isPremium.toString()),
                              ]
                                      .map((e) => FittedBox(
                                          fit: BoxFit.scaleDown, child: e))
                                      .toList()))
                        ],
                      ),
                      gapH30,
                      ElevatedButton(onPressed: () async {
                        final excel = Excel.createExcel();
                        final sheet = excel['Sheet1'];
                        sheet.appendRow(['email', "first name", "last name", "phone number", 'isLogged', 'isPremium']);
                        for (final appUser in data) {
                          sheet.appendRow([
                            appUser.email,
                            appUser.firstName,
                            appUser.lastName,
                            appUser.countryCallingCode + appUser.phoneNumber,
                            appUser.isLogged.toString(),
                            appUser.isPremium.toString(),
                          ]);
                        }

                        // Save the Changes in file
                        final listBytes = excel.encode();
                        final blob = html.Blob([listBytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
                        final url = html.Url.createObjectUrlFromBlob(blob);
                        final anchor = html.document.createElement('a') as html.AnchorElement
                          ..href = url
                          ..style.display = 'none'
                          ..download = 'app_users.xlsx';
                        html.document.body!.children.add(anchor);

                        // download
                        anchor.click();

                        // cleanup
                        html.document.body!.children.remove(anchor);
                        html.Url.revokeObjectUrl(url);


                      }, child: const Text('Export to CSV'))
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
