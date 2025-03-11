import 'package:flutter/material.dart';
import 'package:novo_projeto/data/task_dao.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String name;
  final String photo;
  final int difficulty;
  Task({
    super.key,
    required this.name,
    required this.photo,
    required this.difficulty,
  });

  int nivel = 0;
  int index = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<Color> colorsNivel = <Color>[
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.yellowAccent,
  ];

  maestria() {
    if ((widget.nivel / widget.difficulty) < 5) {
      widget.index = 0;
    } else if ((widget.nivel / widget.difficulty) > 5 &&
        (widget.nivel / widget.difficulty) < 10) {
      widget.index = 1;
    } else if ((widget.nivel / widget.difficulty) > 10 &&
        (widget.nivel / widget.difficulty) < 15) {
      widget.index = 2;
    } else if ((widget.nivel / widget.difficulty) > 15) {
      widget.index = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorsNivel[widget.index],
              borderRadius: BorderRadius.circular(4),
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(4),
                      ),

                      height: 100,
                      width: 72,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child:
                            widget.photo.contains("http")
                                ? Image.network(widget.photo, fit: BoxFit.cover)
                                : Image.asset(widget.photo, fit: BoxFit.cover),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 170,
                          child: Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 24,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Difficulty(widget: widget),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: ElevatedButton(
                        onLongPress:
                            () => showDialog<String>(
                              context: context,
                              builder:
                                  (BuildContext context) => AlertDialog(
                                    title: const Text('Apagar'),
                                    content: const Text(
                                      'Deseja deletar a tarefa?',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed:
                                            () => Navigator.pop(
                                              context,
                                              'Cancel',
                                            ),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          TaskDao().delete(widget.name);
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                            ),

                        onPressed: () {
                          setState(() {
                            widget.nivel++;
                            maestria();
                          });
                        },

                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.blue,
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_drop_up, color: Colors.white),
                            Text(
                              "Up",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value:
                            (widget.difficulty > 0)
                                ? (widget.nivel / widget.difficulty) / 5
                                : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Nivel: ${widget.nivel}",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
