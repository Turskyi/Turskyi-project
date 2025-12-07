enum Time { fade }

extension TimeExtension on Time {
  // START: seconds
  static const int fiveSeconds = 5;

  // END: seconds

  int get value {
    switch (this) {
      case Time.fade:
        return fiveSeconds;
    }
  }
}
