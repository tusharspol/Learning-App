import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/src/Blocs/Authentication_Bloc/Authentication_Bloc.dart';
import 'package:training_app/src/Blocs/Authentication_Bloc/Authentication_Event.dart';
import 'package:training_app/src/Blocs/Authentication_Bloc/Authentication_State.dart';
import 'package:training_app/src/Services/Authentication_Data.dart';
import 'package:training_app/src/SimpleBlocDelegate.dart';
import 'package:bloc/bloc.dart';
import 'package:training_app/src/UI/Home/HomeScreen.dart';
import 'package:training_app/src/UI/Login/Login.dart';


main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatefulWidget {
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  void initState(){
    TimeOfDay td = TimeOfDay.now();
    print(td);
    super.initState();
    _authenticationBloc =
        AuthenticationBloc(authenticationService: _authenticationService);
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      bloc: _authenticationBloc,
      child: MaterialApp(
        title: 'Training App',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          backgroundColor: Colors.white,
          primaryColor: Colors.red,
          fontFamily: 'Poppins',
          pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
        ),
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return Scaffold(body: Container(child: Center(child: Text("The training app", style: TextStyle(fontSize: 20)))));
            }
            if (state is Unauthenticated) {
              return LoginScreen(authenticationBloc: _authenticationBloc,);
            }
            if (state is Authenticated) {
              return HomeScreen();
            }
            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
