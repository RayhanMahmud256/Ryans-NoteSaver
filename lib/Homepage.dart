import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Notesmodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<note> notesd = List.empty(growable: true);
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _notecontroller = TextEditingController();

  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello testing"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),
            TextField(
              controller: _titlecontroller,
              decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _notecontroller,
              maxLines: 5,
              minLines: 2,
              maxLength: 200,
              decoration: InputDecoration(
                  hintText: 'Note',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      String tit = _titlecontroller.text.trim();
                      String not = _notecontroller.text.trim();
                      if (tit.isNotEmpty && not.isNotEmpty) {
                        setState(() {
                          _titlecontroller.text = ' ';
                          _notecontroller.text = ' ';
                          notesd.add(note(title: tit, notes: not));
                        });
                      }
                    },
                    child: const Text('Save')),
                ElevatedButton(onPressed: () {
                  String tit = _titlecontroller.text.trim();
                  String not = _notecontroller.text.trim();
                  if (tit.isNotEmpty && not.isNotEmpty) {
                    setState(() {
                      _titlecontroller.text = ' ';
                      _notecontroller.text = ' ';
                      notesd[selected].title = tit;
                      notesd[selected].notes = not;
                      selected = -1;
                    });
                  }
                }, child: const Text('Update')),
              ],
            ),
            const SizedBox(height: 25),
            notesd.isEmpty
                ? Text('No Note Yet')
                : Expanded(
                    child: ListView.builder(
                        itemCount: notesd.length,
                        itemBuilder: (context, index) => getrow(index)),
                  )
          ],
        ),
      ),
    );
  }

  getrow(int index) {
    return Card(
      child: ListTile(
        onTap: () {
          _titlecontroller.text = notesd[index].title;
          _notecontroller.text = notesd[index].notes;
          setState(() {
            selected = index;
          });
        },
        onLongPress: () {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text("Alert"),
                    content: Text("Are you sure!"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text('Cancel')),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              notesd.removeAt(index);
                            });
                            Navigator.of(ctx).pop();
                          },
                          child: Text('Yes'))
                    ],
                  ));
        },
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                notesd[index].title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Divider(
                color: Colors.black,
                thickness: 0.5,
                indent: 0,
                endIndent: 5,
              ),
              const SizedBox(height: 2),
              Text(notesd[index].notes)
            ],
          ),
        ),
      ),
    );
  }
}
