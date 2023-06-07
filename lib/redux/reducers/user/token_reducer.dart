import 'package:besmart_traveler/redux/actions/auth.dart';

import '../../../models/user/token.dart';
import '../../app_state.dart';


Token? tokenReducer(AppState state, action) {
  if (action is SetToken) {
    return action.token;
  } else if (action is Logout) {
    return null;
  }
  return state.token;
}

