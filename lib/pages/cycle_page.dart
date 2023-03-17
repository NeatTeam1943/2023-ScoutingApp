// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/game_piece.dart';
import 'package:neatteam_scouting_2023/enums/grid_level.dart';
import 'package:neatteam_scouting_2023/enums/grid_zone.dart';
import 'package:neatteam_scouting_2023/enums/pickup_zone.dart';
import 'package:neatteam_scouting_2023/models/cycle.dart';
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/models/team.dart';
import 'package:neatteam_scouting_2023/styles/style_form_field.dart';
import 'package:neatteam_scouting_2023/utils/frc_teams.dart';
import '../providers/matches_provider.dart';
import '../widgets/in_game_action_bar.dart';

class CyclePageProps {
  const CyclePageProps({
    required this.title,
    required this.cycle,
    required this.updateCycle,
    required this.match,
  });

  final String title;
  final int cycle;
  final Function(Function(Cycle cycle) action) updateCycle;
  final int match;
}

class CyclePage extends StatefulWidget {
  const CyclePage({super.key});

  static const routeName = '/cycle';

  @override
  State<StatefulWidget> createState() => CycleState();
}

class CycleState extends State<CyclePage> {
  List<Team> _teams = [];
  final _defendingTeamController = DropdownEditingController<String>();

  CyclePageProps get props =>
      ModalRoute.of(context)!.settings.arguments as CyclePageProps;

  @override
  void initState() {
    super.initState();
    FrcTeams.getAll().then((teams) => setState(() => _teams = teams));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Cycle snapshot = getCycleSnapshot();
      if (snapshot.defendingTeam != null) {
        setState(() {
          _defendingTeamController.value =
              '${snapshot.defendingTeam?.name} #${snapshot.defendingTeam?.number}';
        });
      }
    });
  }

  Cycle get cycle {
    Match match = Provider.of<MatchesProvider>(context).match(props.match);
    if (props.title == 'Autonomous') {
      return match.autonomous!.cycles[props.cycle];
    } else {
      return match.teleop!.cycles[props.cycle];
    }
  }

  Cycle getCycleSnapshot() {
    Match match =
        Provider.of<MatchesProvider>(context, listen: false).match(props.match);
    if (props.title == 'Autonomous') {
      return match.autonomous!.cycles[props.cycle];
    } else {
      return match.teleop!.cycles[props.cycle];
    }
  }

  @override
  Widget build(BuildContext context) {
    Match match =
        Provider.of<MatchesProvider>(context, listen: false).match(props.match);

    return Scaffold(
      appBar: InGameActionBar(
        match: match,
        title: "${props.title} - Cycle ${cycle.cycleNumber}",
      ),
      body: Form(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StyleFormField(
                    field: CheckboxListTile(
                      value: cycle.isDefended,
                      title: const Text("Defended"),
                      onChanged: (value) {
                        props.updateCycle((Cycle cycle) {
                          cycle.isDefended = value!;
                        });
                      },
                    ),
                  ),
                  StyleFormField(
                    field: TextDropdownFormField(
                      controller: _defendingTeamController,
                      dropdownHeight: 420,
                      decoration: _outline(
                        label: 'Select team',
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),
                      onChanged: (dynamic text) {
                        props.updateCycle((Cycle cycle) {
                          cycle.defendingTeam = FrcTeams.makeTeamFromText(text);
                        });
                      },
                      options: _teams.map((team) {
                        return '${team.name} #${team.number}';
                      }).toList(),
                    ),
                  ),
                  StyleFormField(
                    field: DropdownButtonFormField<GamePiece>(
                      value: cycle.gamePiece,
                      decoration: _outline(label: 'Game piece'),
                      onChanged: (gp) =>
                          props.updateCycle((cycle) => cycle.gamePiece = gp),
                      items: GamePiece.values.map((gp) {
                        return DropdownMenuItem<GamePiece>(
                          value: gp,
                          child: Text(gp.name),
                        );
                      }).toList(),
                    ),
                  ),
                  StyleFormField(
                    field: DropdownButtonFormField<PickupZone>(
                      value: cycle.pickupZone,
                      decoration: _outline(label: 'Pickup zone'),
                      onChanged: (pz) =>
                          props.updateCycle((cycle) => cycle.pickupZone = pz),
                      items: PickupZone.values.map((pz) {
                        return DropdownMenuItem<PickupZone>(
                          value: pz,
                          child: Text(pz.name),
                        );
                      }).toList(),
                    ),
                  ),
                  StyleFormField(
                    field: DropdownButtonFormField<GridLevel>(
                      value: cycle.gridLevel,
                      decoration: _outline(label: 'Grid level'),
                      onChanged: (gl) =>
                          props.updateCycle((cycle) => cycle.gridLevel = gl),
                      items: GridLevel.values.map((gl) {
                        return DropdownMenuItem<GridLevel>(
                          value: gl,
                          child: Text(gl.name),
                        );
                      }).toList(),
                    ),
                  ),
                  StyleFormField(
                    field: DropdownButtonFormField<GridZone>(
                      value: cycle.gridZone,
                      decoration: _outline(label: 'Grid zone'),
                      onChanged: (gz) =>
                          props.updateCycle((cycle) => cycle.gridZone = gz),
                      items: GridZone.values.map((gz) {
                        return DropdownMenuItem<GridZone>(
                          value: gz,
                          child: Text(gz.name),
                        );
                      }).toList(),
                    ),
                  ),
                  StyleFormField(
                    field: CheckboxListTile(
                      value: cycle.isSuccessful,
                      title: const Text("Successful"),
                      onChanged: (value) {
                        props.updateCycle((Cycle cycle) {
                          cycle.isSuccessful = value!;
                        });
                      },
                    ),
                  ),
                  StyleFormField(
                    field: CheckboxListTile(
                      value: cycle.isHalf,
                      title: const Text("Half"),
                      onChanged: (value) {
                        props.updateCycle((Cycle cycle) {
                          cycle.isHalf = value!;
                        });
                      },
                    ),
                  ),
                  StyleFormField(
                    field: TextFormField(
                      autofocus: false,
                      initialValue: (cycle.cycleTime ?? 0.0).toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        props.updateCycle(
                            (c) => c.cycleTime = double.tryParse(value));
                      },
                      decoration: const InputDecoration(
                          labelText: "Time docked (in seconds)"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
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
