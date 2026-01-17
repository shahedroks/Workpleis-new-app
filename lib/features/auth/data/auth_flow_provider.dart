import 'package:flutter_riverpod/flutter_riverpod.dart';

enum OtpEntryFlow { forgotPassword, phoneVerification }

final otpEntryFlowProvider = StateProvider<OtpEntryFlow?>((ref) => null);

// Provider to store the OTP that was sent
final sentOtpProvider = StateProvider<String?>((ref) => null);

// Provider to store the phone number
final phoneNumberProvider = StateProvider<String?>((ref) => null);




