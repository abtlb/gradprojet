import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled3/core/storage/storage.dart';
import 'package:untitled3/features/auth/data/data_sources/remote/ApiService.dart';
import 'package:untitled3/features/auth/data/repository/auth_repository_impl.dart';
import 'package:untitled3/features/auth/data/repository/user_repository_impl.dart';
import 'package:untitled3/features/auth/domain/repository/UserRepository.dart';
import 'package:untitled3/features/auth/domain/repository/auth_repository.dart';
import 'package:untitled3/features/auth/domain/usecases/get_users.dart';
import 'package:untitled3/features/auth/domain/usecases/sign_in.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_bloc.dart';
import 'package:untitled3/features/auth/presentation/bloc/remote_user/remote_user_bloc.dart';
import 'package:untitled3/features/chat/data/data_sources/chat_source.dart';
import 'package:untitled3/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:untitled3/features/chat/domain/repositories/chat_repository.dart';
import 'package:untitled3/features/chat/domain/usecases/chat_usecase.dart';
import 'package:untitled3/features/video_home/data/data_source/ConversationService.dart';
import 'package:untitled3/features/video_home/domain/repository/ChatHomeRepository.dart';
import 'package:untitled3/features/video_home/domain/usecase/GetConversationsUsecase.dart';
import 'package:untitled3/features/video_home/domain/usecase/GetSenderIdUsecase.dart';
import 'package:untitled3/features/video_home/presentation/bloc/chat_home_bloc.dart';
import 'package:untitled3/features/video_chat/data/data_sources/AgoraService.dart';
import 'package:untitled3/features/video_chat/data/repository/AgoraVideoChatRepository.dart';
import 'package:untitled3/features/video_chat/domain/repository/VideoChatRepository.dart';
import 'package:untitled3/features/video_chat/domain/usecases/GetLocalUserStreamUsecase.dart';
import 'package:untitled3/features/video_chat/domain/usecases/GetRemoteUserStreamUsecase.dart';
import 'package:untitled3/features/video_chat/domain/usecases/connectToVideoChat.dart';
import 'package:untitled3/features/video_chat/domain/usecases/disconnectFromVideoChat.dart';
import 'package:untitled3/features/video_chat/presentation/bloc/video_chat_bloc.dart';

import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/bloc/auth/sign_up/sign_up_bloc.dart';
import 'features/chat/presentation/blocs/chat_bloc.dart';
import 'features/video_home/data/repository/ChatHomeRepositoryImpl.dart';

final sl = GetIt.instance;

Future<void> initializeDependancies() async {
  sl.registerSingleton<SecureStorage>(
      SecureStorage()
  );

  sl.registerSingleton<Dio>(createDioWithToken(sl()));

  await initializeAuth();

  sl.registerSingleton<ChatService>(ChatService(secureStorage: sl()));

  sl.registerSingleton<ChatRepository>(ChatRepositoryImpl(sl()));

  sl.registerSingleton<ChatUseCase>(ChatUseCase(sl()));

  sl.registerFactory<ChatBloc>(
          () => ChatBloc(chatUseCase: sl())
  );

  sl.registerSingleton<ConversationService>(ConversationService(sl()));
  sl.registerSingleton<ChatHomeRepository>(ChatHomeRepositoryImpl(service: sl(), secureStorage: sl()));
  sl.registerSingleton<GetConversationUsecase>(GetConversationUsecase(chatHomeRepository: sl()));
  sl.registerSingleton<GetSenderIdUseCase>(GetSenderIdUseCase(chatHomeRepository: sl()));
  sl.registerFactory<ChatHomeBloc>(
      () => ChatHomeBloc(getConversationUsecase: sl(), getSenderIdUseCase: sl())
  );

  await initializeVideoChatDependencies();
}

Future<void> initializeAuth() async {
  sl.registerSingleton<ApiService>(ApiService(sl()));

  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(sl(), sl())
  );

  sl.registerSingleton<UserRepository>(
      UserRepositoryImpl(sl())
  );

  sl.registerSingleton<GetUsersUseCase>(
      GetUsersUseCase(sl())
  );

  sl.registerFactory<RemoteUsersBloc>(
          () => RemoteUsersBloc(sl())
  );

  sl.registerSingleton<SignInUseCase>(
      SignInUseCase(sl())
  );

  sl.registerFactory<SignInBloc>(
          () => SignInBloc(sl())
  );

  sl.registerSingleton<SignUpUseCase>(
      SignUpUseCase(authRepository: sl())
  );

  sl.registerFactory<SignUpBloc>(
          () => SignUpBloc(sl())
  );
}

Future<void> initializeVideoChatDependencies() async {
  sl.registerSingleton<AgoraService>(
    AgoraService(sl())
  );

  sl.registerSingleton<VideoChatRepository>(
        AgoraVideoChatRepository(agoraService: sl()),
  );


  // Register the use cases that depend on the repository.
  sl.registerSingleton<ConnectToVideoChatUsecase>(
        ConnectToVideoChatUsecase(repository: sl()),
  );

  sl.registerSingleton<DisconnectFromVideoChatUsecase>(
    DisconnectFromVideoChatUsecase(videoChatRepository: sl()),
  );

  sl.registerSingleton<GetLocalUserStreamUsecase>(
        GetLocalUserStreamUsecase(repository: sl<VideoChatRepository>()),
  );

  sl.registerSingleton<GetRemoteUserStreamUsecase>(
    GetRemoteUserStreamUsecase(repository: sl()),
  );

  // Register the BLoC. Using registerFactory here to create a new instance each time.
  sl.registerFactory<VideoChatBloc>(() => VideoChatBloc(
    connectUsecase: sl(),
    disconnectUsecase: sl(),
    getLocalUserStreamUsecase: sl(),
    getRemoteUserStreamUsecase: sl(),
  ));

}

Dio createDioWithToken(SecureStorage secureStorage) {
  final dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Retrieve the token from secure storage.
        final token = await secureStorage.getToken();
        if (token != null && token.isNotEmpty) {
          // Add the token to the Authorization header.
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
    ),
  );

  return dio;
}