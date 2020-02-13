import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

cachedNetworkImage(mediaUrl) {
  return CachedNetworkImage(
    imageUrl: mediaUrl,
    fit: BoxFit.cover,
    placeholder: (_, url) => Padding(
      padding: EdgeInsets.all(15),
    ),
  );
}
