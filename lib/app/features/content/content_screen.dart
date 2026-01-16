import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/app/app.dart';
import 'package:flutter_application_1/app/features/content/bloc/content_bloc.dart';
import 'package:flutter_application_1/app/features/favorites/bloc/favorites_bloc.dart';
import 'package:flutter_application_1/data/repositories/models/model_info.dart';
import 'package:flutter_application_1/di/di.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({
    super.key,
    required this.contentId,
  });

  final String contentId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ContentBloc>()
            ..add(LoadModelDetails(modelId: contentId)),
        ),
        BlocProvider(
          create: (context) => getIt<FavoritesBloc>()..add(FavoritesLoad()),
        ),
      ],
      child: BlocBuilder<ContentBloc, ContentState>(
        builder: (context, state) {
          if (state is ModelDetailsLoading) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          if (state is ModelDetailsLoaded) {
            return _buildContent(context, state.model);
          }
          if (state is ModelDetailsLoadingFailure) {
            return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: _buildError(context, state.exception),
            );
          }
          return Scaffold(appBar: AppBar());
        },
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context, String modelId) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final isFavorite = state is FavoritesLoaded &&
            state.favoriteIds.contains(modelId);
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: () {
            if (isFavorite) {
              context.read<FavoritesBloc>().add(FavoritesRemove(modelId: modelId));
            } else {
              context.read<FavoritesBloc>().add(FavoritesAdd(modelId: modelId));
            }
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, ModelInfo model) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.id, overflow: TextOverflow.ellipsis),
        actions: [
          _buildFavoriteButton(context, model.id),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/photo1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            16.ph,
            Text(
              'Model ID: ${model.id}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            8.ph,
            if (model.pipelineTag != null)
              Text('Task: ${model.pipelineTag}', style: Theme.of(context).textTheme.titleMedium),
            24.ph,

            Text('Model Files:', style: Theme.of(context).textTheme.titleLarge),
            10.ph,
            if (model.siblings != null && model.siblings!.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: model.siblings!.length,
                itemBuilder: (context, index) {
                  final file = model.siblings![index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.insert_drive_file_outlined),
                      title: Text(file.rfilename),
                    ),
                  );
                },
              )
            else
              const Text('No file information available.'),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, Object exception) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Failed to load model details'),
          Text(exception.toString()),
          20.ph,
          ElevatedButton(
            onPressed: () {
              context.read<ContentBloc>().add(LoadModelDetails(modelId: contentId));
            },
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
