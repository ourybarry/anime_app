import 'package:anime/resources/model/post/user_post.dart';
import 'package:anime/ui/components/post_card/user_post_card.dart';
import 'package:flutter/material.dart';

class UserActivity extends StatefulWidget {
  const UserActivity({Key? key}) : super(key: key);

  @override
  State<UserActivity> createState() => _UserActivityState();
}

class _UserActivityState extends State<UserActivity> {
  List<String> posts = ['a', 'b', 'c'];
  @override
  Widget build(BuildContext context) {
    return posts.length == 0
        ? EmptyActivity()
        : ListView.separated(
            itemBuilder: (context, index) => UserPostCard(),
            separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                ),
            itemCount: posts.length);
  }
}

//Widget to display when user doesn't have any activity yet
class EmptyActivity extends StatelessWidget {
  const EmptyActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('You don\'t have any activity yet'),
          MaterialButton(
            onPressed: () {},
            child: Text('Create post'),
          )
        ],
      ),
    );
  }
}
