import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/models/team.dart';
import 'package:neatteam_scouting_2023/styles/style_form_field.dart';
import 'package:neatteam_scouting_2023/utils/frc_teams.dart';

class TeamInfoFormPage extends StatefulWidget {
  const TeamInfoFormPage({super.key});

  static const routeName = '/add-match';

  @override
  State<StatefulWidget> createState() => _TeamInfoForm();
}

class _TeamInfoForm extends State<TeamInfoFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _matchController = TextEditingController();

  final _selectedTeamTextController = TextEditingController();
  String? _selectedAlliance;

  List<Team> _teams = [];

  @override
  void initState() {
    super.initState();
    FrcTeams.getAll().then((teams) => setState(() => _teams = teams));
  }

  @override
  void dispose() {
    _matchController.dispose();
    _selectedTeamTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team info')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            StyleFormField(
              field: TextFormField(
                controller: _matchController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter match number!';
                  } else if (int.tryParse(value) == null) {
                    return 'Please enter a numeric value!';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Match",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                ),
              ),
            ),
            StyleFormField(
              field: TextDropdownFormField(
                options: _teams.map((team) {
                  return '${team.teamName} #${team.teamNumber}';
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: "Select team",
                ),
                dropdownHeight: 420,
              ),
            ),
            StyleFormField(
              field: DropdownButtonFormField(
                value: _selectedAlliance,
                items: ['Red', 'Blue'].map((color) {
                  return DropdownMenuItem<String>(
                    value: color,
                    child: Text(color),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select an alliance!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  labelText: "Select alliance",
                ),
                onChanged: (color) => setState(() => _selectedAlliance = color),
              ),
            ),
            StyleFormField(
              field: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Match match = Match(scouterName: '');
                    match.matchNumber = int.parse(_matchController.text);
                    Navigator.pushNamed(context, '/match', arguments: match);
                  }
                },
                child: const Text(
                  "NEXT",
                  style: TextStyle(fontSize: 35),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
