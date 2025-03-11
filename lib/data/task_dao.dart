import 'package:novo_projeto/components/task.dart';
import 'package:novo_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql =
      'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tablename = "taskTable";
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {
    print("iniciando seve");
    final Database bancoDeDados = await getDatabase();

    var itemExists = await find(tarefa.name);

    Map<String, dynamic> taskMap = toMap(tarefa);

    if (itemExists.isEmpty) {
      print("a tarefa nao existia");
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print("a tarefa ja existia");

      return bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.name],
      );
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print("convertendo para map");

    final Map<String, dynamic> mapaDeTarefas = {};
    mapaDeTarefas[_name] = tarefa.name;
    mapaDeTarefas[_difficulty] = tarefa.difficulty;
    mapaDeTarefas[_image] = tarefa.photo;

    print("Mapa de tarefas $mapaDeTarefas");

    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    print("acessando findall");
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
    );
    print("procurando dados ... encontrado $result");
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print("convertendo tolist");

    final List<Task> tarefas = [];

    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(
        name: linha[_name],
        photo: linha[_image],
        difficulty: linha[_difficulty],
      );
      tarefas.add(tarefa);
    }
    print("lista de tarefas $tarefas");
    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    print("acessando find");
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
    print("Tarefa encontrada ${toList(result)}");

    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print("deletando uma tarefa");
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
  }
}
