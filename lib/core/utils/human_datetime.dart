class HumanFormat {
  static String datetime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays > 0) {
      return '${diff.inDays} d';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} h';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} m';
    } else if (diff.inSeconds > 0) {
      return '${diff.inSeconds} s';
    } else {
      return '';
    }
  }
}
