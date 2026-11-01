# Agents Guide

This file gives concise, actionable guidance to AI coding agents working on this
Flutter monolithic site (personal landing page). Only project-discoverable
patterns are documented - follow these references before changing behaviour.

## Quick start (commands)

- Install deps: `flutter pub get`
- Run analyzer: `flutter analyze .` (project requires fixes before PRs)
- Run tests: `flutter test` (unit/widget tests in `test/`)
- Run web locally: `flutter run -d chrome` or `flutter run -d web-server`
- Build web release: `flutter build web --release`

## Big-picture architecture

- Monolithic Model-View-Presenter (MVP) Flutter app. See `README.md` and
  the `lib/` tree for the structure.
- Composition root: `lib/main.dart` - resolves dependencies, calls
  `di.injectDependencies()`, initializes localization and constructs `App`.
- Dependency holder: `lib/di/dependencies.dart` and injector in
  `lib/di/injector.dart` - prefer changing wiring here when you need new
  runtime services.

## Major components & data flow

- Models & data sources: `lib/model/*` — local persistence lives in
  `lib/model/data_sources/local/local_data_source.dart` (wraps
  `SharedPreferences`).
- Presenters: `lib/presenter/*` - business logic using `ChangeNotifier`.
  Example: `HomePresenter` (see `lib/presenter/home_presenter.dart`) contains
  UI actions, URL health checks (Dio + CORS-proxy fallback) and language logic.
- Views & routes: `lib/view/*` — `App` in `lib/view/app.dart`, route map is
  built by `lib/view/routes/routes.dart` using `getRouteMap(localDataSource)`.

## Project-specific conventions

- Prefer explicit `else` blocks over early-return guard clauses (see
  `.github/copilot-instructions.md`). Follow this style when refactoring.
- Always run `flutter analyze .` after code changes and resolve reported
  issues before submitting changes (project policy in
  `.github/copilot-instructions.md`).
- Presenters are the single place for business logic - avoid putting logic in
  view widgets. Use `ChangeNotifier` patterns already in `presenter/`.

## Localization & language selection

- Uses `flutter_translate`. Initialization happens at DI time
  (`lib/di/injector.dart`) and `main.dart` wraps app in `LocalizedApp`.
- Language detection logic is in
  `lib/model/data_sources/local/local_data_source.dart` (examines
  `SharedPreferences`, `PlatformDispatcher.instance.locale`, `Uri.base.host` and
  `Uri.base.fragment`). Changing language behaviour must consider these checks.

## External integrations & important packages

- Key packages: `shared_preferences`, `flutter_translate`, `dio`,
  `url_launcher`, `retrofit`, `json_annotation`. Check `pubspec.yaml` for full
  list.
- Backend API: Cloudflare Worker proxy (`turskyi-support-api`) at `https://turskyi-support-api.dmytro-turskyi.workers.dev/support`. Source code: `backend/turskyi-support-api/worker.js`. Accessed in Flutter via Retrofit client `SupportApiClient` (`lib/model/data_sources/remote/support_api_client.dart`).
- URL health check + fallback logic lives in
  `HomePresenter.checkAndLaunchProjectWebsite`.
  Be careful when editing - logic includes direct HEAD checks, CORS proxy retry,
  and multiple fallback branches.

## CI / deployment notes

- GitHub Actions are used to build and deploy to GitHub Pages on pushes to
  `master` (see `.github/workflows/`). Don't rely on local-only deploy scripts.

## Where to make changes

- UI look-and-feel: `lib/res/values/themes.dart` and `lib/view/app.dart`.
- Colours/configs at runtime: `lib/res/configs/*` and `MainConfigs` used in DI.
- Adding runtime services: update `lib/di/dependencies.dart` and
  `lib/di/injector.dart`; this keeps composition root changes localized.

## Safety & debugging tips

- Many code paths use `kDebugMode` guarded `debugPrint` calls (see
  `HomePresenter`) - use these when testing locally.
- When changing network logic, run web locally and inspect Chrome DevTools for
  CORS vs DNS errors; Dio may surface both as connection errors.

## Quick file references

- Composition root: `lib/main.dart`
- DI: `lib/di/injector.dart`, `lib/di/dependencies.dart`
- Presenters: `lib/presenter/` (notably `home_presenter.dart`)
- Data source: `lib/model/data_sources/local/local_data_source.dart`
- Routes: `lib/view/routes/routes.dart`
- App shell: `lib/view/app.dart`

If anything in this file is unclear, or you need a behaviour clarified, ask the
repo owner before making assumptions (see `.github/copilot-instructions.md`).

# This file should never exceed 200 lines of code, meaning, this line should never be below line number 200. If we need to add something to this file, we simply have to remove something less critical.

