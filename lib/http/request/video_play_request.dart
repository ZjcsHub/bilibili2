import 'home_request.dart';

class VideoPlayRequest extends HomeRequest {
  @override
  String path() {
    return "x/player/playurl";
  }
}
