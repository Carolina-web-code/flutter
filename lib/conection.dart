import 'package:core_retail/presentation/connection/connection.dart';
import 'package:core_retail/presentation/services/bloc/local_server_connection_bloc/local_server_connection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/scan.dart';

class ConnectionWidget extends StatelessWidget {
  const ConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocalServerConnectionBloc, LocalServerConnectionState>(
      listener: (BuildContext context, LocalServerConnectionState state) {
        switch (state) {
          case LocalServerConnectionInitial():
            break;
          case LocalServerConnectionLoading():
            break;
          case LocalServerConnectionFailure():
            break;
          case LocalServerConnectionLoaded():
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => PizzaPage())
            );
            break;
        }
      },
      child: const Scaffold(body: Center(child: ConnectionPage())),
    );
  }
}
