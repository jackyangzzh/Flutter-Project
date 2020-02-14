import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

cachedNetworkImage(mediaUrl) {
  return CachedNetworkImage(
    imageUrl: mediaUrl,
    fit: BoxFit.cover,
    placeholder: (_, url) => Image.asset('assets/images/placeholder.png'),
    errorWidget: (_, url, error) => Icon(Icons.error),
  );
}
