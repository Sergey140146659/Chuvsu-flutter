import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/data/repositories/models/model_info.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
    required this.model,
  });

  final ModelInfo model;

  @override
  Widget build(BuildContext context) {
    const double imageSize = 100.0;
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        final encodedId = Uri.encodeComponent(model.id);
        context.push('/content/$encodedId');
      },
      child: SizedBox(
        height: imageSize,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/photo1.jpg',
                height: imageSize,
                width: imageSize,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.id,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  if (model.pipelineTag != null)
                    Text(
                      model.pipelineTag!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
