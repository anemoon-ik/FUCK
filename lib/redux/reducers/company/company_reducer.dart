import '../../../models/company/Company.dart';
import '../../../models/pagination.dart';
import '../../actions/pagination.dart';
import '../../app_state.dart';

Pagination companyReducer(AppState state, action) {
  if (action is SetPgn && action.name == Company.modelName) {
    return action.pgn;
  }
  if (action is UpdatePgn && action.name == Company.modelName) {
    action.pgn.results = state.companies.results + action.pgn.results;
    return action.pgn;
  }
  return state.companies;
}
