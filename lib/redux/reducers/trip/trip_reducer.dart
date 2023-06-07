import '../../../models/pagination.dart';
import '../../../models/trip/trip.dart';
import '../../actions/pagination.dart';
import '../../app_state.dart';

Pagination tripReducer(AppState state, action) {
  if (action is SetPgn && action.name == Trip.modelName) {
    return action.pgn;
  }
  return state.trips;
}
