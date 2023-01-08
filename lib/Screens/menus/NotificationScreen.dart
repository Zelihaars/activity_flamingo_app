import 'package:flamingo_app/Models/Activity.dart';
import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final String currentUserId;
  const NotificationScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Activity> _activities = [];

  setupActivities() async {
    List<Activity> activities =
    await DatabaseServices.getActivities(widget.currentUserId);
    if (mounted) {
      setState(() {
        _activities = activities;
      });
    }
  }

  buildActivity(Activity activity) {
    return FutureBuilder(
        future: usersRef.doc(activity.fromUserId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return SizedBox.shrink();
          } else {
            UserModel user = UserModel.fromDoc(snapshot.data);
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: user.profilePicture.isEmpty
                        ? AssetImage('assets/images/placeholder.png')as ImageProvider
                        : NetworkImage(user.profilePicture),
                  ),
                  title: activity.follow == true
                      ? Text('${user.name} seni takip etti')
                      : Text('${user.name} paylaşımını beğendi'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    color: kPrimaryColor,
                    thickness: 1,
                  ),
                )
              ],
            );
          }
        });
  }

  @override
  void initState() {
    super.initState();
    setupActivities();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: kPrimaryColor,
          title: Text(
            'Bildirimler',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => setupActivities(),
          child: ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (BuildContext context, int index) {
                Activity activity = _activities[index];
                return buildActivity(activity);
              }),
        )
    );
  }
}
