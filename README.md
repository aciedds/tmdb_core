# tmdb_core

`tmdb_core` adalah package data/domain untuk integrasi TMDB yang sudah menyiapkan:

- konfigurasi environment API,
- inisialisasi service (`Dio` dan `SharedPreferences`),
- repository siap pakai,
- kumpulan use case siap inject (`TmdbCoreUseCases`).

## Install

Tambahkan dependency:

```yaml
dependencies:
  tmdb_core:
    path: ../tmdb_core
```

Atau pakai git/pub sesuai kebutuhan project.

## Quick Start

### 1) Initialize sekali saat app start

```dart
import 'package:flutter/widgets.dart';
import 'package:tmdb_core/tmdb_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await TmdbCore.initialize(
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: 'YOUR_TMDB_API_KEY',
    imageBaseUrl: 'https://image.tmdb.org/t/p/w500',
    largeImageBaseUrl: 'https://image.tmdb.org/t/p/original',
    appName: 'My App',
    appVersion: '1.0.0',
    debugMode: true,
  );

  runApp(const MyApp());
}
```

### 2) Ambil repository/usecases dari factory

```dart
final repository = TmdbCore.createFilmRepository();
final useCases = TmdbCore.createUseCases();
```

## Integrasi dengan GetIt

```dart
import 'package:get_it/get_it.dart';
import 'package:tmdb_core/tmdb_core.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  await TmdbCore.initialize(
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: 'YOUR_TMDB_API_KEY',
    imageBaseUrl: 'https://image.tmdb.org/t/p/w500',
    largeImageBaseUrl: 'https://image.tmdb.org/t/p/original',
    appName: 'My App',
    appVersion: '1.0.0',
    debugMode: true,
  );

  sl.registerLazySingleton<FilmRepository>(
    () => TmdbCore.createFilmRepository(),
  );

  sl.registerLazySingleton<TmdbCoreUseCases>(
    () => TmdbCore.createUseCases(),
  );
}
```

## Contoh Pemakaian Use Case

```dart
final useCases = TmdbCore.createUseCases();

final popularResult = await useCases.getPopularFilmUc(page: 1);
final nowPlayingResult = await useCases.getNowPlayingUc(page: 1);
final searchResult = await useCases.getSearchFilmUc('interstellar');
```

## Available Use Cases

`TmdbCoreUseCases` menyediakan:

- `getPopularFilmUc`
- `getNowPlayingUc`
- `getMovieGenresUc`
- `getSimilarFilmUc`
- `getSimilarFilmByGenresUc`
- `getSearchFilmUc`
- `getMovieVideosUc`
- `getFavoriteUc`
- `getWatchlistUc`
- `getHasExistInFavoriteUc`
- `getHasExistInWatchlistUc`
- `addFavoriteUc`
- `addWatchlistUc`
- `removeFromFavoriteUc`
- `removeFromWatchlistUc`

## Notes

- Selalu panggil `TmdbCore.initialize()` sebelum memanggil factory lain.
- Jika butuh reset dependency cache (misalnya untuk test), gunakan `TmdbCore.reset()`.
- Local storage internal package menggunakan `SharedPreferences`.
