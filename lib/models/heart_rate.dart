class HeartRate {
  final DateTime time;
  final int bpm;

  HeartRate({required this.time, required this.bpm});
}

/// Sample historical heart rate data
final List<HeartRate> sampleHeartRates = [
  HeartRate(time: DateTime.now().subtract(const Duration(minutes: 5)), bpm: 72),
  HeartRate(time: DateTime.now().subtract(const Duration(minutes: 4)), bpm: 75),
  HeartRate(time: DateTime.now().subtract(const Duration(minutes: 3)), bpm: 70),
  HeartRate(time: DateTime.now().subtract(const Duration(minutes: 2)), bpm: 73),
  HeartRate(time: DateTime.now().subtract(const Duration(minutes: 1)), bpm: 71),
];
