import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';

import '../../theme/app_dimensions.dart';
import '../../theme/app_text.dart';
import '../../theme/spacer.dart';

class ErrorBox extends StatelessWidget {
  final Object error;
  final StackTrace stackTrace;
  final VoidCallback tryAgain;

  const ErrorBox({
    super.key,
    required this.error,
    required this.stackTrace,
    required this.tryAgain,
  });

  static const defaultPadding = EdgeInsets.symmetric(
    horizontal: AppDimensions.spacingMedium,
    vertical: AppDimensions.spacingSmall,
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final strings = IntlStrings.of(context);
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMedium,
        ),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusMedium,
          ),
        ),
        child: Padding(
          padding: defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: colorScheme.onErrorContainer,
                  ),
                  HSpacer.medium,
                  Text(
                    strings.errorBoxTitle.toUpperCase(),
                    style: AppText.textLarge500.copyWith(
                      color: colorScheme.onErrorContainer,
                    ),
                  ),
                ],
              ),
              Text(
                strings.errorBoxDescription(error.toString()),
                style: AppText.textSmall.copyWith(
                  color: colorScheme.onErrorContainer,
                ),
              ),
              TextButton(
                onPressed: () => _showMyDialog(context, strings),
                child: Text(
                  strings.errorBoxStackTrace,
                  style: AppText.textLarge500
                      .copyWith(color: colorScheme.onErrorContainer),
                ),
              ),
              TextButton(
                onPressed: tryAgain,
                child: Text(
                  strings.tryAgain,
                  style: AppText.textLarge500
                      .copyWith(color: colorScheme.onErrorContainer),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context, IntlStrings strings) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(strings.stackTraceTitle),
          content: SingleChildScrollView(
            child: Text(stackTrace.toString()),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(strings.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
