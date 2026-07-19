enum BarcodeType { code128, code39, ean13, ean8, upcA, upcE, itf, codabar }

extension BarcodeTypeExtension on BarcodeType {
  String get title {
    switch (this) {
      case BarcodeType.code128:
        return "Code 128";

      case BarcodeType.code39:
        return "Code 39";

      case BarcodeType.ean13:
        return "EAN-13";

      case BarcodeType.ean8:
        return "EAN-8";

      case BarcodeType.upcA:
        return "UPC-A";

      case BarcodeType.upcE:
        return "UPC-E";

      case BarcodeType.itf:
        return "ITF";

      case BarcodeType.codabar:
        return "Codabar";
    }
  }
}
