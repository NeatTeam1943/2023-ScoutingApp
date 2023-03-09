// Project imports:
import 'package:neatteam_scouting_2023/models/cycle.dart';

class Teleop {
  Teleop() : cycles = [];

  List<Cycle> cycles;

  updateCycle(int index, Function(Cycle cycle) action) {
    action(cycles[index]);
  }
}
