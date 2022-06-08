import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class UserPostCardHeader extends StatelessWidget {
  const UserPostCardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 20.0,
            backgroundImage: NetworkImage(
                'https://kitsu.io/images/default_avatar-2ec3a4e2fc39a0de55bf42bf4822272a.png'),
          ),
          Column(
            children: [
              Text(
                'Username',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'bottom',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          Spacer(),
          IconButton(
              onPressed: () {},
              icon: Icon(
                FeatherIcons.moreHorizontal,
                color: Colors.grey,
              ))
        ],
      ),
    );
  }
}
