// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/alliance.dart';
import 'package:neatteam_scouting_2023/enums/driver_station.dart';
import 'package:neatteam_scouting_2023/match_data_csv.dart';
import 'package:neatteam_scouting_2023/models/autonomous.dart';
import 'package:neatteam_scouting_2023/models/cycle.dart';
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/models/team.dart';
import 'package:neatteam_scouting_2023/models/teleop.dart';

const String expectedMatchDataCSV =
    "1,1943,NeatTeam,1,blue,3,0,0,false,,false,,\r\n"
    "2,1943,NeatTeam,2,red,2,0,0,false,,false,,\r\n"
    "3,1942,Cinderella,23,blue,1,0,0,false,,false,,";

void testMatchData(List<Team> teams) {}

void main() {
  Teleop teleop = Teleop()
    ..cycles = [
      Cycle(cycleNumber: 0),
      Cycle(cycleNumber: 1),
      Cycle(cycleNumber: 2),
      Cycle(cycleNumber: 3),
    ];

  Autonomous auto = Autonomous()
    ..cycles = [
      Cycle(cycleNumber: 0),
    ];

  Team neatteam = Team()
    ..name = "NeatTeam"
    ..number = 1943;

  Team cinderella = Team()
    ..name = "Cinderella"
    ..number = 1942;

  final List<Match> matches = [
    Match(scouterName: "Shapiron")
      ..number = 1
      ..team = neatteam
      ..alliance = Alliance.blue
      ..driverStation = DriverStation.third
      ..teleop = teleop,
    Match(scouterName: "Shapiron")
      ..number = 2
      ..team = neatteam
      ..alliance = Alliance.red
      ..driverStation = DriverStation.second
      ..autonomous = auto,
    Match(scouterName: "Yifat")
      ..number = 23
      ..team = cinderella
      ..alliance = Alliance.blue
      ..driverStation = DriverStation.first
      ..teleop = teleop,
  ];

  group("CSV Generation:", () {
    test("Match data should generate according to DB", () {
      expect(expectedMatchDataCSV, makeMatchDataCSV(matches));
    });
  });
}
