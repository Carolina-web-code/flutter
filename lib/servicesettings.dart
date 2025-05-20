import 'package:core_retail/presentation/services/bloc/local_server_connection_bloc/local_server_connection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:core_retail/presentation/services/services_setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/scan.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ServicesSetting());
  }

}
