import 'package:anime/ui/themes/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class UserPostCardBottom extends StatelessWidget {
  const UserPostCardBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FeatherIcons.heart,
                    color: Colors.red,
                    size: 16,
                  )),
              Text(
                'user1, user2 and many others liked this post',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
          TextField(
            onTap: () {
              _openCommentBox(context);
            },
            decoration: InputDecoration(
                hintText: 'Leave a comment',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: CustomColors.SURFACE_COLOR),
          )
        ],
      ),
    );
  }

  void _openCommentBox(context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(FeatherIcons.x)),
                          Text('Leave a comment')
                        ],
                      ),
                      ElevatedButton(onPressed: () {}, child: Text('Comment'))
                    ],
                  ),
                ),
                TextField(
                  maxLines: 10,
                  // style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: true,
                      fillColor: CustomColors.SURFACE_COLOR,
                      focusColor: CustomColors.SURFACE_COLOR,
                      hintText: 'Type comment...'),
                )
              ],
            ),
          );
        });
  }
}
