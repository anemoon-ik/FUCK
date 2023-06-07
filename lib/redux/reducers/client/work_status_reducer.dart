import '../../../models/client/work_status.dart';
import '../../../models/pagination.dart';
import '../../actions/pagination.dart';
import '../../app_state.dart';

Pagination workStatusReducer(AppState state, action) {
  if (action is SetPgn && action.name == WorkStatus.modelName) {
    return action.pgn;
  }
  return state.workStatus;
}
