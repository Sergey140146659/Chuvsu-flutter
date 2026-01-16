import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/di/di.dart';
import 'bloc/favorites_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FavoritesBloc>()..add(FavoritesLoad()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Избранное'),
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FavoritesLoaded) {
              if (state.favoriteIds.isEmpty) {
                return const Center(
                  child: Text('Нет избранных моделей'),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.favoriteIds.length,
                itemBuilder: (context, index) {
                  final modelId = state.favoriteIds[index];
                  return ListTile(
                    title: Text(modelId),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      final encodedId = Uri.encodeComponent(modelId);
                      context.push('/content/$encodedId');
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            }
            if (state is FavoritesFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ошибка загрузки'),
                    Text(state.error),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<FavoritesBloc>().add(FavoritesLoad());
                      },
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
