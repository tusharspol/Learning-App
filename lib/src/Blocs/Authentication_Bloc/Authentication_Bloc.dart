import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:training_app/src/Blocs/Authentication_Bloc/Authentication_Event.dart';
import 'package:training_app/src/Blocs/Authentication_Bloc/Authentication_State.dart';
import 'package:training_app/src/Services/Authentication_Data.dart';


class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

final AuthenticationService _authenticationService;

  AuthenticationBloc({@required AuthenticationService authenticationService})
      : assert(authenticationService != null),
        _authenticationService = authenticationService;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    } else if (event is LogIn) {
      yield* _mapLoginToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    bool isUserRegistered = await _authenticationService.isUserAuthenticated();    
    if(isUserRegistered){
      yield Authenticated("Tushar");
    }
    else {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final isFreshlyRegistered = true;
    if(isFreshlyRegistered){
      // yield RegisteredState();
    }else{
      yield Authenticated("Tushar");
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
  }

  Stream<AuthenticationState> _mapLoginToState() async* {
    bool isUserLoggedIn = await _authenticationService.authenticateUser("emailID", "password");
    if(isUserLoggedIn){
      yield Authenticated("Tushar");
    }else {
      yield Unauthenticated();
    }
  }
}
