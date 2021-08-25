import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/widgets/team_standing_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamStandings extends StatefulWidget {
  const TeamStandings({Key? key}) : super(key: key);

  @override
  _TeamStandingsState createState() => _TeamStandingsState();
}

class _TeamStandingsState extends State<TeamStandings> {
  List<Team> teams = [];
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Teams>(
        context,
        listen: false,
      ).fetchAndSetTeams().then(
            (value) => setState(
              () => _isLoading = false,
            ),
          );
    }
    _isInit = false;
  }

  TextStyle standingTextStyle = TextStyle(
    fontSize: 20,
    color: CustomColors.firebaseGrey,
  );

  @override
  Widget build(BuildContext context) {
    teams = Provider.of<Teams>(
      context,
      listen: false,
    ).teams;
    if (_isLoading) {
      return CircularProgressIndicator();
    } else {
      return Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              
              pinned: true,
              expandedHeight: 160.0,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text(
                  'Standings',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.left,
                ),
                background: FlutterLogo(),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Material(
                  color: CustomColors.secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.firebaseYellow,
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(),
                        // ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'MP',
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.firebaseYellow,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'MW',
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.firebaseYellow,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'ML',
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.firebaseYellow,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'PT',
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.firebaseYellow,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'RD',
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.firebaseYellow,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // if (index == 0) {
                  //   return
                  // } else {
                  return TeamStandingCard(teams[index]);
                  // }
                },
                childCount: teams.length,
              ),
            ),
          ],
        ),
      );
    }
  }
}