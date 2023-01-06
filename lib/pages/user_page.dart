import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  static const routeName = '/user';

  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool showWeekly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BBAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 220,
            child: Stack(
              children: [
                FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.7,
                  child: Container(
                    color: Colors.grey.shade500,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Theme.of(context).canvasColor,
                      ),
                      const CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(
                          "./images/profile_picture_placeholder.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Username",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          const XPBar(),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.45,
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              border: Border.all(color: Colors.grey.shade700, width: 5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: const Text(
                          "Statystyki",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Switch(
                        activeColor: Colors.deepPurple,
                        activeTrackColor: Colors.deepPurple.shade300,
                        inactiveThumbColor: Colors.blueGrey.shade600,
                        inactiveTrackColor: Colors.grey.shade500,
                        value: showWeekly,
                        onChanged: (value) => setState(() {
                          showWeekly = value;
                        }),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: const [
                        StatsTile(
                          icon: Icon(Icons.pedal_bike),
                          title: "Przejechany Dystans",
                          value: "420km",
                        ),
                        StatsTile(
                          icon: Icon(Icons.local_fire_department),
                          title: "Spalone kalorie",
                          value: "7kcal",
                        ),
                        StatsTile(
                          icon: Icon(Icons.timer),
                          title: "Czas jazdy",
                          value: "02:10:37",
                        ),
                        StatsTile(
                          icon: Icon(Icons.calendar_month),
                          title: "Dni pod rząd",
                          value: "69",
                        ),
                        StatsTile(
                          icon: Icon(Icons.emoji_events),
                          title: "Najdłuższy przejazd",
                          value: "200km",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatsTile extends StatelessWidget {
  final String title;
  final String value;
  final Icon icon;

  const StatsTile(
      {required this.icon,
      required this.title,
      required this.value,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: icon,
        textColor: Colors.black,
        iconColor: Colors.black,
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 20),
        ),
        title: Text(title),
      ),
    );
  }
}

class XPBar extends StatelessWidget {
  const XPBar({super.key});

  final xp = 21;
  final totalXp = 37;
  final level = 69;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 15,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: xp / totalXp,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text("Lv $level"),
          ],
        ),
        Text("$xp/$totalXp XP"),
      ],
    );
  }
}
