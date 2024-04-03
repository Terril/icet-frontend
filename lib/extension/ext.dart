import 'package:flutter/cupertino.dart';

String filterNull(String? input) {
  if (input == null) {
    return "";
  }
  return input;
}

List<T> filterNullList<T>(List<T>? input) {
  if (input == null || input.isEmpty) {
    return List.empty();
  }
  return input;
}

int filterNullInt(int? input) {
  if (input == null) {
    return 0;
  }
  return input;
}

bool filterBoolNull(bool? input) {
  if (input == null) {
    return false;
  }
  return input;
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final matrix = renderObject?.getTransformTo(null);

    if (matrix != null && renderObject?.paintBounds != null) {
      final rect = MatrixUtils.transformRect(matrix, renderObject!.paintBounds);
      return rect;
    } else {
      return null;
    }
  }
}
