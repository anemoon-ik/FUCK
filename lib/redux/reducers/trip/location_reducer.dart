import '../../../models/pagination.dart';
import '../../../models/trip/location.dart';
import '../../actions/pagination.dart';
import '../../app_state.dart';

Pagination locationReducer(AppState state, action) {
  if (action is SetPgn && action.name == Location.modelName) {
    return action.pgn;
  }
  if (action is UpdatePgn && action.name == Location.modelName) {
    action.pgn.results = state.locations.results + action.pgn.results;
    return action.pgn;
  }
  return state.locations;
}
