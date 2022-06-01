import 'package:anime/resources/model/anime/anime.dart';
import 'package:anime/ui/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class HomeItemCard<T> extends StatelessWidget {
  final T item;

  const HomeItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic item = this.item;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: 150,
          child: Image.network(
            item.posterImage.original,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          width: 150,
          child: Text(
            item.canonicalTitle,
            style: Theme.of(context).textTheme.headline3,
          ),
        )
      ],
    );
  }
}

class HomeItemCardLoading extends StatelessWidget {
  final _shimmerGradient = const LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  const HomeItemCardLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return _shimmerGradient.createShader(bounds);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            width: 150,
            color: Colors.black,
          ),
          Container(
            width: 150,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
