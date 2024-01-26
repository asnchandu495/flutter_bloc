import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_structure/Model/Model.dart';
import 'package:flutter_bloc_structure/Services/repositories.dart';
import 'package:flutter_bloc_structure/bloc_cubit/app_blocs.dart';
import 'package:flutter_bloc_structure/bloc_cubit/app_events.dart';
import 'package:flutter_bloc_structure/bloc_cubit/app_states.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(title: const Text('Flutter BloC')),
          body: blocBody()),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(),
      )..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserErrorState) {
            return const Center(child:  Text("Error"));
          }
          if (state is UserLoadedState) {
            List<Data> userList = state.users;

            return _getUsersListView(userList);
          }

          return Container();
        },
      ),
    );
  }

  Widget _getUsersListView(List<Data>? users) {
    return ListView.builder(
        itemCount: users?.length,
        itemBuilder: (context, position) {
          return _getUserListItem(users![position]);
        });
  }
  Widget _getUserListItem(Data item) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Image.network(item.avatar!),
        title: Text(
          item.firstName! + " " + item.lastName!,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        subtitle: Text(
          item.email!,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        trailing: Text('ID: ' + item.id.toString()),
      ),
    );

  }
}




