import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dialogs/editable_dialog.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeActivity(),
    );
  }
}

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  late TextEditingController noteEditingController;
  NoteModel? _model;

  @override
  void initState() {
    noteEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_model != null) {
      noteEditingController.text = _model?.note ?? "";
    }
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: noteEditingController,
                        decoration: const InputDecoration(
                          hintText: "Write a note...",
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        String note = noteEditingController.text;
                        if (note.isNotEmpty) {
                          int timeMills = DateTime.now().millisecondsSinceEpoch;
                          NoteModel model = NoteModel(
                            timeMills: timeMills,
                            id: timeMills.toString(),
                            note: note,
                          );
                          add(model);
                          noteEditingController.text = "";
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter your note...!"),
                            ),
                          );
                        }
                      },
                      child: const Text("Add"),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_model != null) {
                          String note = noteEditingController.text;
                          if (note.isNotEmpty) {
                            update(_model!.copy(note: note));
                            _model = null;
                            noteEditingController.text = "";
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please enter your note then update...!",
                                ),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please select your note then update...!",
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text("Update"),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: Colors.white.withOpacity(0.50),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: const Text(
                        "Streaming notes",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: notesStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data ?? [];
                          return Column(
                            children: data.map((e) {
                              return NoteWidget(
                                model: e,
                                onUpdate: (model) {
                                  setState(() => _model = model);
                                },
                                onDelete: delete,
                              );
                            }).toList(),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> add(NoteModel model) {
  return FirebaseFirestore.instance
      .collection("notes")
      .doc(model.id ?? "")
      .set(model.source);
}

Future<void> update(NoteModel model) {
  return FirebaseFirestore.instance
      .collection("notes")
      .doc(model.id ?? "")
      .update(model.source);
}

Future<void> delete(String id) {
  return FirebaseFirestore.instance.collection("notes").doc(id).delete();
}

Future<List<NoteModel>> fetchNotes() async {
  var data = await FirebaseFirestore.instance.collection("notes").get();
  List<NoteModel> list = [];
  for (var i in data.docs) {
    NoteModel model = NoteModel.from(i.data());
    list.add(model);
  }
  return list;
}

Stream<List<NoteModel>> notesStream() {
  StreamController<List<NoteModel>> controller = StreamController();
  FirebaseFirestore.instance.collection("notes").snapshots().listen((data) {
    List<NoteModel> list = [];
    for (var i in data.docs) {
      NoteModel model = NoteModel.from(i.data());
      list.add(model);
    }
    controller.add(list);
  });
  return controller.stream;
}

class NoteWidget extends StatelessWidget {
  final NoteModel model;
  final void Function(NoteModel model) onUpdate;
  final void Function(String id) onDelete;

  const NoteWidget({
    super.key,
    required this.model,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      margin: const EdgeInsets.only(bottom: 1.5),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(child: Text(model.note ?? "")),
          IconButton(
            padding: const EdgeInsets.all(8),
            icon: const Icon(
              Icons.edit,
              color: Colors.orange,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return NoteUpdateDialog(
                    initialText: model.note,
                    hint: "Enter your update note ... ",
                    onUpdate: (value) => update(model.copy(note: value)),
                  );
                },
              );
            },
          ),
          const SizedBox(width: 8),
          IconButton(
            padding: const EdgeInsets.all(8),
            icon: const Icon(
              Icons.clear,
              color: Colors.red,
            ),
            onPressed: () {
              if (model.id != null) {
                onDelete(model.id!);
              }
            },
          ),
        ],
      ),
    );
  }
}

class NoteModel {
  final int? timeMills;
  final String? id;
  final String? note;

  const NoteModel({
    this.timeMills,
    this.id,
    this.note,
  });

  static int get generateTimeMills {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String get generateNoteId => "$generateTimeMills";

  NoteModel copy({
    int? timeMills,
    String? id,
    String? note,
  }) {
    return NoteModel(
      timeMills: timeMills ?? this.timeMills,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  factory NoteModel.from(Map<String, dynamic> source) {
    var timeMills = source["time_mills"];
    var id = source["id"];
    var note = source["note"];
    return NoteModel(
      timeMills: timeMills is int ? timeMills : 0,
      id: id is String ? id : null,
      note: note is String ? note : null,
    );
  }

  Map<String, dynamic> get source {
    return {
      "time_mills": timeMills,
      "id": id,
      "note": note,
    };
  }
}
