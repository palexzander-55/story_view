import 'package:rxdart/rxdart.dart';

enum PlaybackState { pause, play, reset, next, previous, positionUpdate, goTo, seekForward, seekBack }

/// Controller to sync playback between animated child (story) views. This
/// helps make sure when stories are paused, the animation (gifs/slides) are
/// also paused.
/// Another reason for using the controller is to place the stories on `paused`
/// state when a media is loading.
class StoryController {
  /// Stream that broadcasts the playback state of the stories.
  final playbackNotifier = BehaviorSubject<PlaybackState>();
  double position;
  int newIndex;

  /// Notify listeners with a [PlaybackState.pause] state
  void pause() {
    playbackNotifier.add(PlaybackState.pause);
  }

  /// Notify listeners with a [PlaybackState.play] state
  void play() {
    playbackNotifier.add(PlaybackState.play);
  }

  void reset() {
    playbackNotifier.add(PlaybackState.reset);
  }

  void next() {
    playbackNotifier.add(PlaybackState.next);
  }

  void previous() {
    playbackNotifier.add(PlaybackState.previous);
  }

  void animationPosition(double p) {
    position = p;
    playbackNotifier.add(PlaybackState.positionUpdate);
  }

  void goTo(int x) {
    newIndex = x;
    playbackNotifier.add(PlaybackState.goTo);
  }

  void seekForward() {
    playbackNotifier.add(PlaybackState.seekForward);
  }

  void seekBack(){
    playbackNotifier.add(PlaybackState.seekBack);
  }
  /// Remember to call dispose when the story screen is disposed to close
  /// the notifier stream.
  void dispose() {
    playbackNotifier.close();
  }
}
