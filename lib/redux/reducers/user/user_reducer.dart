
import '../../../models/user/User.dart';
import '../../actions/auth.dart';
import '../../actions/registration_client.dart';
import '../../app_state.dart';



User userReducer(AppState state, action) {
  if (action is RegistrationUser){
    return action.user;
  }
  if (action is SetUser){
    return action.user;
  }
  return state.user;
}

