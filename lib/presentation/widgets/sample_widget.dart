import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/sample_entity.dart';

class SampleWidget extends StatelessWidget {
  final SampleEntity entity;
  const SampleWidget({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: entity.imageUrl,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        title: Text(entity.title),
        subtitle: Text('ID: ${entity.id}'),
      ),
    );
  }
}
