import 'package:flutter/material.dart';

class ItemGrid<T> extends StatelessWidget {
  final List<T> items;

  const ItemGrid({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 180),
        itemBuilder: (context, index) {
          return SingleItem(item: items.elementAt(index));
        });
  }
}

class SingleItem<T> extends StatelessWidget {
  final T item;

  const SingleItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic item = this.item;
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            // height: 100,
            width: MediaQuery.of(context).size.width / 2,
            constraints: BoxConstraints.expand(),
            child: Image.network(
              item.posterImage.original,
              fit: BoxFit.cover,
            ),
          ),
          // Positioned(
          //     height: 30,
          //     bottom: 0,
          //     left: 0,
          //     right: 0,
          //     child: Opacity(
          //       opacity: 0.5,
          //       child: Container(
          //         color: Colors.black,
          //         child: Text(
          //           item.canonicalTitle,
          //           style: Theme.of(context).textTheme.headline3,
          //         ),
          //       ),
          //     )),
        ],
      ),
      // Container(
      //   child: Text(
      //     item.canonicalTitle,
      //     style: Theme.of(context).textTheme.headline3,
      //   ),
      // )
    );
  }
}
