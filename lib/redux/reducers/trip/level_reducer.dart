import '../../../models/pagination.dart';
import '../../../models/trip/Level.dart';
import '../../actions/pagination.dart';
import '../../app_state.dart';

Pagination levelReducer(AppState state, action) {
  if (action is SetPgn && action.name == Level.modelName) {
    return action.pgn;
  }
  return state.levels;
}
