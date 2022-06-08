import 'package:anime/ui/components/post_card/user_post_card_bottom.dart';
import 'package:anime/ui/components/post_card/user_post_card_header.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserPostCard extends StatelessWidget {
  const UserPostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          UserPostCardHeader(),
          ReadMoreText(
              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
          UserPostCardBottom(),
        ],
      ),
    );
  }
}
