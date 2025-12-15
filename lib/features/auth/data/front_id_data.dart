class DocumentScanStore {
  static String documentName = "Identity Card";
  static String placeholderAsset = "assets/images/nid.png";
  static String? capturedImagePath;

  // ✅ Face photo
  static String? faceImagePath;

  static void setDoc({required String name, required String placeholder}) {
    documentName = name;
    placeholderAsset = placeholder;
  }

  static void setCaptured(String path) => capturedImagePath = path;
  static void clearCaptured() => capturedImagePath = null;

  static void setFaceCaptured(String path) => faceImagePath = path;
  static void clearFaceCaptured() => faceImagePath = null;


  // ✅ video selfie captured image
  static String? videoSelfieImagePath;

  static void setVideoSelfieCaptured(String path) {
    videoSelfieImagePath = path;
  }

  static void clearVideoSelfieCaptured() {
    videoSelfieImagePath = null;
  }



}
