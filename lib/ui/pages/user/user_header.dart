import 'package:anime/resources/model/user/user.dart';
import 'package:anime/ui/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  final User user;
  UserHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: CustomColors.SURFACE_COLOR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  maxRadius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://kitsu.io/images/default_avatar-2ec3a4e2fc39a0de55bf42bf4822272a.png'),
                ),
                TextButton(onPressed: () {}, child: Text('Edit profile'))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                user.name,
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: 50,
              child: _header(),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        GestureDetector(
          child: Column(
            children: [
              Text(
                user.postsCount.toString(),
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Posts',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        GestureDetector(
          child: Column(
            children: [
              Text(
                user.followersCount.toString(),
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Followers',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        GestureDetector(
          child: Column(
            children: [
              Text(
                user.followingCount.toString(),
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Following',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        )
      ],
    );
  }
}
