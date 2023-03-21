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
import 'package:neatteam_scouting_2023/storage.dart';
import 'package:neatteam_scouting_2023/styles/style_form_field.dart';
import 'package:neatteam_scouting_2023/utils/frc_teams.dart';
import '../widgets/sliding_segmented_control.dart';

class TeamInfoPage extends StatefulWidget {
  const TeamInfoPage({super.key});

  static const routeName = '/add-match';

  @override
  State<StatefulWidget> createState() => _TeamInfoForm();
}

class _TeamInfoForm extends State<TeamInfoPage> {
  final _formKey = GlobalKey<FormState>();

  final _scouterNameController = TextEditingController();
  final _matchNumberController = TextEditingController();
  final _selectedTeamController = DropdownEditingController<String>();

  final _match = Match();

  List<Team> _teams = [];

  @override
  void initState() {
    super.initState();
    FrcTeams.getAll().then((teams) => setState(() => _teams = teams));
    _match.alliance = Alliance.blue;
    _match.driverStation = DriverStation.first;
    initAsyncState();
  }

  Future<void> initAsyncState() async {
    String? scouterName = await Storage.getScouterName();
    if (scouterName != null) {
      _scouterNameController.text = scouterName;
    }
  }

  @override
  void dispose() {
    _scouterNameController.dispose();
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
              // Scouter Name field
              StyleFormField(
                field: TextFormField(
                  controller: _scouterNameController,
                  validator: _validateScouterName,
                  decoration: _outline(label: 'Scouter name'),
                ),
              ),

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
              const Text('Alliance'),
              StyleFormField(
                field: SlidingSegmentedControl<Alliance>(
                  value: _match.alliance,
                  onChange: (al) => setState(() => _match.alliance = al),
                  segments: Alliance.values,
                  colors: const {
                    Alliance.red: Colors.red,
                    Alliance.blue: Colors.blue,
                  },
                ),
              ),

              // Driver station selection
              const Text('Driver station'),
              StyleFormField(
                field: SlidingSegmentedControl<DriverStation>(
                  value: _match.driverStation,
                  onChange: (ds) => setState(() => _match.driverStation = ds),
                  segments: DriverStation.values,
                  colors: const {
                    DriverStation.first: Colors.blue,
                    DriverStation.second: Colors.blue,
                    DriverStation.third: Colors.blue,
                  },
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

  /// Returns error message ([String]) in case [value] is empty
  String? _validateScouterName(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter scouter name!';
    }

    return null;
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

  /// Validate form and submit it (Moving to the next page [MatchPage])
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedTeamController.value == null) {
        return;
      }

      _match.scouterName = _scouterNameController.text;
      _match.number = int.parse(_matchNumberController.text);
      _match.team = FrcTeams.makeTeamFromText(_selectedTeamController.value!);

      Storage.saveScouterName(_match.scouterName);

      Provider.of<MatchesProvider>(context, listen: false).addMatch(_match);
      Navigator.pushNamed(context, '/autonomous', arguments: _match.number);
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
