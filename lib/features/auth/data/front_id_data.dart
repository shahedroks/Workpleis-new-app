class DocumentScanStore {
  static String documentName = "Identity Card";
  static String placeholderAsset = "assets/images/nid.png";
  static String? capturedImagePath;

  static void setDoc({
    required String name,
    required String placeholder,
  }) {
    documentName = name;
    placeholderAsset = placeholder;
  }

  static void setCaptured(String path) {
    capturedImagePath = path;
  }

  static void clearCaptured() {
    capturedImagePath = null;
  }
}
