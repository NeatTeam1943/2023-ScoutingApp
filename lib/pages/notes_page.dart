// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../styles/style_form_field.dart';
import '../utils/match_state.dart';
import '../widgets/in_game_action_bar.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  static const routeName = '/notes';

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends MatchState<NotesPage> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (snapshot.notes != null) {
        setState(() => _notesController.text = snapshot.notes!);
      }
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _goHome() {
    String notes = _notesController.text;
    if (notes.isNotEmpty) {
      updateMatch((m) {
        m.notes = notes;
      });
    }

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InGameActionBar(
        match: match,
        showFinish: false,
        title: const Text("Match Notes"),
      ),
      body: Form(
        key: _formKey,
        child: StyleFormField(
          field: TextFormField(
            maxLines: 10,
            enabled: match.finished,
            controller: _notesController,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goHome,
        label: const Text('Finito!'),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
