import 'package:flutter/material.dart';
import 'package:novo_projeto/data/task_dao.dart';
import 'package:novo_projeto/screens/add_task.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: Container(),
        actions: [IconButton(onPressed: (){setState(() {});}, icon: Icon(Icons.refresh, color: Colors.black,),),],
        title: Text(
          "Tarefas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
          future: TaskDao().findAll(),
          builder: (context, snapshot) {
            List<Task>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    Text('Carregando'),
                  ],),
                );
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    Text('Carregando'),
                  ],),
                );
                break;
              case ConnectionState.active:
                return Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    Text('Carregando'),
                  ],),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Task tarefa = items[index];
                        return tarefa;
                      },
                    );
                  }
                  return Center(
                    child: Column(
                      children: [
                        Icon(Icons.error_outline, size: 128),
                        Text(
                          'Não ha nenhuma tarefa',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  );
                }
                return Text('Erro ao carregar tarefas');
                break;
            }
            return Text('Erro desconhecido');
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder:
                  (BuildContext contextNew) => AddTask(taskContext: context),
            ),
            
          ).then((value) => setState((){}));
        },
      ),
    );
  }
}
