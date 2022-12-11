import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'interface/user_list/user_list.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: UserListScreen(),
      ),
    ),
  );
}
