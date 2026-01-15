import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/app/app.dart';
import 'package:flutter_application_1/app/features/home/bloc/home_bloc.dart';
import 'package:flutter_application_1/data/services/auth_service_interface.dart';
import 'package:flutter_application_1/di/di.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(LoadModelsList()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hugging Face Models'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await getIt<AuthServiceInterface>().logOut();
                if (context.mounted) {
                  context.go('/login');
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is ModelsListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ModelsListLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.modelsList.length,
                itemBuilder: (context, index) {
                  final model = state.modelsList[index];
                  return ContentCard(model: model);
                },
                separatorBuilder: (context, index) => 16.ph,
              );
            }
            if (state is ModelsListLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Failed to load models'),
                    Text(state.exception.toString()),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(LoadModelsList());
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text('Press button to load models'),
            );
          },
        ),
      ),
    );
  }
}
