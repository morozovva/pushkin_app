enum SortingType {
  popular,
  alpha,
  near;
}

class SortingHelper {
  ///возврат текста тайла по типу сортировки
  static String getValue(SortingType type) {
    switch (type) {
      case SortingType.popular:
        return "по популярности";
      case SortingType.alpha:
        return "по алфавиту";
      case SortingType.near:
        return "по близости";
      default:
        return "";
    }
  }
}
