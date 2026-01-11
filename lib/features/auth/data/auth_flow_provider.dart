import 'package:flutter_riverpod/flutter_riverpod.dart';

enum OtpEntryFlow { forgotPassword, phoneVerification }

final otpEntryFlowProvider = StateProvider<OtpEntryFlow?>((ref) => null);




