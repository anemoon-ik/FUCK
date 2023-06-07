import '../../../models/client/client.dart';
import '../../actions/auth.dart';
import '../../actions/registration_client.dart';
import '../../app_state.dart';

Client clientReducer(AppState state, action) {
  if (action is RegistrationClient) {
    return action.client;
  }
  if (action is SetClient) {
    return action.client;
  }
  return state.client;
}
