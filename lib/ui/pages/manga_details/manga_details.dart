import 'package:anime/resources/model/manga/manga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class MangaDetails extends StatelessWidget {
  final Manga manga;

  MangaDetails({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(10),
              title: Text(
                manga.canonicalTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              background: Stack(children: [
                Container(
                  width: double.infinity,
                  child: Image.network(
                    manga.posterImage.original,
                    color: Color(0x00000055),
                    colorBlendMode: BlendMode.multiply,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.grey.withOpacity(0.0),
                            Colors.black.withOpacity(0.6)
                          ],
                          stops: [
                            0.0,
                            1.0
                          ])),
                )
              ])),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          // Text(Manga.canonicalTitle),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'type',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'age',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                RatingBar.builder(
                    initialRating: 12.9,
                    minRating: 0,
                    allowHalfRating: true,
                    itemCount: 5,
                    maxRating: 100,
                    itemSize: 15,
                    itemBuilder: (context, index) {
                      return Icon(
                        Icons.star,
                        color: Colors.amber,
                        // size: 4,
                      );
                    },
                    onRatingUpdate: (rating) {
                      print(rating.toString());
                    }),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Text(
                //           'Published',
                //           style: Theme.of(context).textTheme.headline2,
                //         ),
                //         Text('1984', style: TextStyle(color: Colors.white))
                //       ],
                //     ),
                //   ],
                // ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text('Synopsis',
                            style: Theme.of(context).textTheme.headline2),
                      ),
                      ReadMoreText(manga.synopsis.toString()),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]))
      ]),
    );
  }
}
