import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../data/api/todo_api.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../data/repositories/food_analysis_repository_impl.dart';
import '../../data/services/openai_food_analysis_service.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/repositories/food_analysis_repository.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../data/repositories/websocket_chat_repository_impl.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio instance
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
  )));

  // Services
  getIt.registerLazySingleton<OpenAIFoodAnalysisService>(
    () => OpenAIFoodAnalysisService(),
  );

  // APIs
  getIt.registerLazySingleton<TodoApi>(
    () => TodoApi(getIt<Dio>()),
  );

  // Repositories
  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(getIt<TodoApi>()),
  );

  getIt.registerLazySingleton<FoodAnalysisRepository>(
    () => FoodAnalysisRepositoryImpl(getIt<OpenAIFoodAnalysisService>()),
  );

  getIt.registerLazySingleton<ChatRepository>(
    () => WebSocketChatRepositoryImpl(),
  );
}
