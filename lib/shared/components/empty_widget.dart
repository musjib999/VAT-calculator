import 'package:flutter/material.dart';

import '../../core/gen/assets.gen.dart';
import '../widgets.dart';

class EmptyWidget extends StatelessWidget {
  final EmptyType emptyType;
  const EmptyWidget({super.key, this.emptyType = EmptyType.noRecord});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(emptyType.image, height: 100, width: 100),
        const SizedBox(height: 5),
        Text(
          emptyType.title,
          style: AppTextStyle.body.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          emptyType.message,
          textAlign: TextAlign.center,
          style: AppTextStyle.body,
        ),
      ],
    );
  }
}

enum EmptyType {
  noRecord,
  noInternet,
  noNotifications;

  bool get isNoData => this == EmptyType.noRecord;
  bool get isNoInternet => this == EmptyType.noInternet;
  bool get isNoNotifications => this == EmptyType.noNotifications;

  String get message {
    switch (this) {
      case EmptyType.noRecord:
        return 'No data available';
      case EmptyType.noInternet:
        return 'No internet connection';
      case EmptyType.noNotifications:
        return 'Your update notifications will appear here';
    }
  }

  String get image {
    switch (this) {
      case EmptyType.noRecord:
        return Assets.images.noRecord.path;
      case EmptyType.noInternet:
        return Assets.images.noRecord.path;
      case EmptyType.noNotifications:
        return Assets.images.noNotification.path;
    }
  }

  String get title {
    switch (this) {
      case EmptyType.noRecord:
        return 'No record yet';
      case EmptyType.noInternet:
        return 'No Internet';
      case EmptyType.noNotifications:
        return 'Nothing to see here';
    }
  }
}
