import 'dart:async';

enum SizeEvent { event_small, event_middle, event_big }

class SizeBloc {
  double _size = 100;

  final _inputEventController = StreamController<SizeEvent>();
  StreamSink<SizeEvent> get inputEventSink => _inputEventController.sink;

  final _outputStateController = StreamController<double>();
  Stream<double> get outputStateStream => _outputStateController.stream;

  void _mapEventToState(SizeEvent event) {
    if (event == SizeEvent.event_small) {
      _size = 100;
    } else if (event == SizeEvent.event_middle) {
      _size = 300;
    } else if (event == SizeEvent.event_big) {
      _size = 550;
    } else
      throw Exception("Wrong Event Type");

    _outputStateController.sink.add(_size);
  }

  SizeBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }

  void dispoce() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
