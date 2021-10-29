class DialogHandledException implements Exception {
  final String message;
  DialogHandledException(this.message);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is DialogHandledException) {
      if (message == other.message) return true;
    } else {
      return false;
    }
    return false;
  }

  @override
  String toString() => message;

  @override
  int get hashCode => message.hashCode;
}
