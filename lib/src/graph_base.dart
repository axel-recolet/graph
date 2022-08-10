import './graph_event.dart';
import './state.dart';

class Graph<T> {
  final Set<T> nodes;

  Graph(this.nodes);

  Iterable<State<T>> run({required State<T> initState}) {
    try {
      var states = {initState};
      var nextStates = <State<T>>{};
      final prevStates = <State<T>>{};
      final results = <State<T>>{};

      END:
      while (states.isNotEmpty) {
        STATE:
        for (final state in states) {
          for (final node in nodes) {
            try {
              state.evaluate(node, prevStates, states, nextStates, results);
            } catch (e) {
              if (e is! GraphEvent) {
                rethrow;
              } else if (e is NextState) {
                continue STATE;
              } else if (e is BreakStates) {
                break STATE;
              } else if (e is End) {
                break END;
              }
            }
          }
        }
        states = Set.from(nextStates);
        nextStates.clear();
      }
      return results;
    } catch (e) {
      rethrow;
    }
  }
}
