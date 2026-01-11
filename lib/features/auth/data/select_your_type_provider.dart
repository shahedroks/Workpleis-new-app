import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserRole { client, provider }

final selectedUserRoleProvider = StateProvider<UserRole?>((ref) => null);
