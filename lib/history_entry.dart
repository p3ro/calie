class HistoryEntry {
  String title;
  String result;
  String calculation;
  bool isFavorite = false;
  DateTime date = DateTime.now();

  HistoryEntry(
      {this.title = "", required this.result, required this.calculation});

  void changeFavorite() {
    isFavorite = !isFavorite;
  }

  static int _compareByDate(HistoryEntry a, HistoryEntry b) {
    if (a.date.isBefore(b.date)) {
      return 1;
    } else if (a.date.isAfter(b.date)) {
      return -1;
    }
    return 0;
  }

  static int _compareByFav(HistoryEntry a, HistoryEntry b) {
    if (a.isFavorite && !b.isFavorite) {
      return -1;
    } else if (a.isFavorite && b.isFavorite) {
      return _compareByDate(a, b);
    } else if (!a.isFavorite && !b.isFavorite) {
      return 0;
    }
    return 1;
  }

  static void sortByDate(List<HistoryEntry> h) {
    h.sort(_compareByDate);
  }

  static void sortByFavorite(List<HistoryEntry> h) {
    h.sort(_compareByFav);
  }
}
