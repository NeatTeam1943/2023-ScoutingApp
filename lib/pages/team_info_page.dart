// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/alliance.dart';
import 'package:neatteam_scouting_2023/enums/driver_station.dart';
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/models/team.dart';
import 'package:neatteam_scouting_2023/providers/matches_provider.dart';
import 'package:neatteam_scouting_2023/styles/style_form_field.dart';
import 'package:neatteam_scouting_2023/utils/frc_teams.dart';

class TeamInfoPage extends StatefulWidget {
  const TeamInfoPage({super.key});

  static const routeName = '/add-match';

  @override
  State<StatefulWidget> createState() => _TeamInfoForm();
}

class _TeamInfoForm extends State<TeamInfoPage> {
  final _formKey = GlobalKey<FormState>();

  final _matchNumberController = TextEditingController();
  final _selectedTeamController = DropdownEditingController<String>();

  DriverStation? _selectedDriverStation = DriverStation.first;
  Alliance? _selectedAlliance = Alliance.blue;

  final _match = Match(scouterName: '');

  List<Team> _teams = [];

  @override
  void initState() {
    super.initState();
    FrcTeams.getAll().then((teams) => setState(() => _teams = teams));
  }

  @override
  void dispose() {
    _matchNumberController.dispose();
    _selectedTeamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team info')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Match number field
              StyleFormField(
                field: TextFormField(
                  controller: _matchNumberController,
                  validator: _validateMatchNumber,
                  keyboardType: TextInputType.number,
                  decoration: _outline(label: 'Match'),
                ),
              ),

              // Team selection
              StyleFormField(
                field: TextDropdownFormField(
                  controller: _selectedTeamController,
                  validator: _validateTeam,
                  dropdownHeight: 420,
                  decoration: _outline(
                    label: 'Select team',
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                  options: _teams.map((team) {
                    return '${team.name} #${team.number}';
                  }).toList(),
                ),
              ),

              // Alliance selection
              StyleFormField(
                field: DropdownButtonFormField<Alliance>(
                  value: _selectedAlliance,
                  validator: _validateAlliance,
                  decoration: _outline(label: 'Select alliance'),
                  onChanged: (color) =>
                      setState(() => _selectedAlliance = color),
                  items: Alliance.values.map((color) {
                    return DropdownMenuItem<Alliance>(
                      value: color,
                      child: Text(color.name),
                    );
                  }).toList(),
                ),
              ),

              // Driver station selection
              StyleFormField(
                field: DropdownButtonFormField<DriverStation>(
                  value: _selectedDriverStation,
                  validator: _validateDriverStation,
                  decoration: _outline(label: 'Select driver station'),
                  onChanged: (color) =>
                      setState(() => _selectedDriverStation = color),
                  items: DriverStation.values.map((station) {
                    return DropdownMenuItem<DriverStation>(
                      value: station,
                      child: Text(station.name),
                    );
                  }).toList(),
                ),
              ),

              // Submission button
              StyleFormField(
                field: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text(
                    'NEXT',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns error message ([String]) in case [value] is not int
  String? _validateMatchNumber(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter match number!';
    } else if (int.tryParse(value) == null) {
      return 'Please enter a numeric value!';
    }

    return null;
  }

  /// Returns error message ([String]) in case [value] is empty
  String? _validateTeam(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter team!';
    }

    return null;
  }

  /// Returns error message ([String]) in case [value] is empty
  String? _validateAlliance(value) {
    if (value == null) {
      return 'Please select an alliance!';
    }

    return null;
  }

  /// Returns error message ([String]) in case [value] is empty
  String? _validateDriverStation(value) {
    if (value == null) {
      return 'Please select a driver station!';
    }

    return null;
  }

  /// Extract team number from "<Team name> #<Team number>"
  Team _makeTeamFromText(String fullTeamText) {
    List<String> parts = fullTeamText.split(" #");
    return Team()
      ..number = int.parse(parts[1])
      ..name = parts[0];
  }

  /// Validate form and submit it (Moving to the next page [MatchPage])
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedTeamController.value == null) {
        return;
      }

      _match.number = int.parse(_matchNumberController.text);
      _match.alliance = _selectedAlliance;
      _match.team = _makeTeamFromText(_selectedTeamController.value!);
      _match.driverStation = _selectedDriverStation;

      Provider.of<MatchesProvider>(context, listen: false).addMatch(_match);
      Navigator.pushNamed(context, '/match', arguments: _match);
    }
  }

  /// [FormField] outline input decoration
  InputDecoration _outline({required String label, Icon? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black38),
      ),
    );
  }
}
