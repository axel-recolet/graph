abstract class State<T> {
  void evaluate(T node, Set<State<T>> prevStates, Set<State<T>> states,
      Set<State<T>> nextStates, Set<State<T>> results);
}