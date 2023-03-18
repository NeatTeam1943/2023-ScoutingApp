// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

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
import 'package:neatteam_scouting_2023/widgets/sliding_segmented_control.dart';
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

  int currentTime = 0;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

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

      if (snapshot.cycleTime == null) {
        _stopWatchTimer.onStartTimer();
        _stopWatchTimer.rawTime.listen((time) => currentTime = time);
      } else {
        currentTime = (snapshot.cycleTime! * 1000).toInt();
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  Cycle? get cycle {
    Match match = Provider.of<MatchesProvider>(context).match(props.match);
    if (props.title == 'Auto') {
      if (match.autonomous!.cycles.length > props.cycle) {
        return match.autonomous!.cycles[props.cycle];
      }
    } else {
      if (match.teleop!.cycles.length > props.cycle) {
        return match.teleop!.cycles[props.cycle];
      }
    }

    return null;
  }

  Cycle getCycleSnapshot() {
    Match match =
        Provider.of<MatchesProvider>(context, listen: false).match(props.match);
    if (props.title == 'Auto') {
      return match.autonomous!.cycles[props.cycle];
    } else {
      return match.teleop!.cycles[props.cycle];
    }
  }

  void checkFinish() {
    Cycle cycle = getCycleSnapshot();
    if (cycle.gamePiece != null &&
        cycle.pickupZone != null &&
        cycle.gridLevel != null &&
        cycle.gridZone != null) {
      finishCycle();
    }
  }

  void finishCycle() {
    Cycle cycle = getCycleSnapshot();
    _stopWatchTimer.onStopTimer();
    cycle.cycleTime = currentTime / 1000.0;
    Navigator.pop(context, cycle.isSuccessful);
    cycle.finished = true;
  }

  @override
  Widget build(BuildContext context) {
    Match match =
        Provider.of<MatchesProvider>(context, listen: false).match(props.match);

    if (cycle == null) {
      return const Scaffold();
    }

    return Scaffold(
      appBar: InGameActionBar(
        match: match,
        title: StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          builder: (context, snap) {
            final displayTime =
                StopWatchTimer.getDisplayTime(currentTime, hours: false);
            final half = cycle!.isHalf ? "(Half)" : "";

            return Text(
                "${props.title} - Cycle ${cycle!.cycleNumber}\n$half $displayTime");
          },
        ),
      ),
      body: Form(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Is Defended field
                    StyleFormField(
                      field: CheckboxListTile(
                        value: cycle!.isDefended,
                        title: const Text("Defended"),
                        onChanged: (value) {
                          props.updateCycle((Cycle cycle) {
                            cycle.isDefended = value!;
                            cycle.defendingTeam = null;
                          });
                        },
                      ),
                    ),

                    // Defending team field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24)
                          .copyWith(bottom: 16),
                      child: AbsorbPointer(
                        absorbing: !cycle!.isDefended,
                        child: TextDropdownFormField(
                          controller: _defendingTeamController,
                          dropdownHeight: 420,
                          decoration: _outline(
                            label: 'Select team',
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                          ),
                          onChanged: (dynamic text) {
                            props.updateCycle((Cycle cycle) {
                              cycle.defendingTeam =
                                  FrcTeams.makeTeamFromText(text);
                            });
                          },
                          options: _teams.map((team) {
                            return '${team.name} #${team.number}';
                          }).toList(),
                        ),
                      ),
                    ),

                    // Pickup Zone field
                    const Text("Pickup zone"),
                    StyleFormField(
                      field: SlidingSegmentedControl<PickupZone>(
                        value: cycle!.pickupZone,
                        onChange: (pz) {
                          props.updateCycle((cycle) => cycle.pickupZone = pz);
                          checkFinish();
                        },
                        segments: PickupZone.values,
                        colors: {
                          PickupZone.feeder: Colors.blue.shade600,
                          PickupZone.floor: Colors.green.shade900,
                        },
                      ),
                    ),

                    // Game Piece field
                    const Text("Game piece"),
                    StyleFormField(
                      field: SlidingSegmentedControl<GamePiece>(
                        value: cycle!.gamePiece,
                        onChange: (gp) {
                          props.updateCycle((cycle) => cycle.gamePiece = gp);
                          checkFinish();
                        },
                        segments: GamePiece.values,
                        colors: {
                          GamePiece.cube: Colors.indigo,
                          GamePiece.cone: Colors.yellow.shade700,
                        },
                      ),
                    ),

                    // Grid Level field
                    const Text("Grid level"),
                    StyleFormField(
                      field: SlidingSegmentedControl<GridLevel>(
                        value: cycle!.gridLevel,
                        onChange: (gl) {
                          props.updateCycle((cycle) => cycle.gridLevel = gl);
                          checkFinish();
                        },
                        segments: GridLevel.values,
                        colors: {
                          GridLevel.low: Colors.red,
                          GridLevel.middle: Colors.yellow.shade700,
                          GridLevel.high: Colors.green,
                        },
                      ),
                    ),

                    // Grid Zone field
                    const Text("Grid zone"),
                    StyleFormField(
                      field: SlidingSegmentedControl<GridZone>(
                        value: cycle!.gridZone,
                        onChange: (gz) {
                          props.updateCycle((cycle) => cycle.gridZone = gz);
                          checkFinish();
                        },
                        segments: GridZone.values,
                        colors: {
                          GridZone.onBorder: Colors.blue.shade600,
                          GridZone.coOp: Colors.green,
                          GridZone.onFeeder: Colors.blue.shade600,
                        },
                      ),
                    ),

                    // Is Successful field
                    CheckboxListTile(
                      enabled: cycle!.finished,
                      value: cycle!.isSuccessful,
                      title: const Text("Successful"),
                      onChanged: (value) {
                        props.updateCycle((Cycle cycle) {
                          cycle.isSuccessful = value!;
                        });
                      },
                    ),

                    // Is Half field
                    CheckboxListTile(
                      enabled: cycle!.finished,
                      value: cycle!.isHalf,
                      title: const Text("Half"),
                      onChanged: (value) {
                        props.updateCycle((Cycle cycle) {
                          cycle.isHalf = value!;
                        });
                      },
                    ),

                    Container(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          getCycleSnapshot().isSuccessful = false;
          finishCycle();
        },
        label: const Text('Failed'),
        icon: const Icon(Icons.cancel),
      ),
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
