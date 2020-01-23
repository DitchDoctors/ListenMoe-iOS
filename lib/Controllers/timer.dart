
class MoeTimer {
  final String startTime;
  final int duration;

  MoeTimer({this.startTime, this.duration});

  get currentPosition {
    int totalTime = DateTime.parse(startTime).second;
    return duration - totalTime;
  }
  


}