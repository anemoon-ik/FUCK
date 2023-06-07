import '../../../models/client/family_status.dart';
import '../../../models/pagination.dart';
import '../../actions/pagination.dart';
import '../../app_state.dart';

Pagination familyStatusReducer(AppState state, action) {
  if (action is SetPgn && action.name == FamilyStatus.modelName) {
    return action.pgn;
  }
  return state.familyStatus;
}
