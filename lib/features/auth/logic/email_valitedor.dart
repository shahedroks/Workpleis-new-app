String? emailValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Email / phone is required';
  final value = v.trim();

  // Accept either a valid email OR a phone number (digits, optional leading +)
  final email = RegExp(r'^[\w\.\-]+@[\w\-]+\.[\w\.\-]+$');
  final phone = RegExp(r'^\+?\d{7,15}$');

  if (!email.hasMatch(value) && !phone.hasMatch(value)) {
    return 'Enter a valid email or phone number';
  }
  return null;
}
