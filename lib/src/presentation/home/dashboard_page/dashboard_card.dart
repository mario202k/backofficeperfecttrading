import 'package:backoffice/src/presentation/common_widget/async_value_widget.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardCard extends StatelessWidget {
  final AsyncValue value;
  final String title;
  final Widget icon;

  const DashboardCard(
      {Key? key, required this.value, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: context.theme.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.theme.primaryColor),
            boxShadow: [
              BoxShadow(
                color: context.theme.colorScheme.onSurface.withOpacity(0.2),
                blurRadius: 18,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 3,
                height: 50,
                color: context.theme.primaryColor,
              ),
              Flexible(
                child: Column(
                  children: [
                    FittedBox(child: Text(title)),
                    AsyncValueWidget(value: value, data: (nb){
                      return Text(nb.toString());
                    }),
                  ],
                ),
              ),
              icon
            ],
          )),
    );
  }
}
