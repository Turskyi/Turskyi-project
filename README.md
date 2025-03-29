[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://stand-with-ukraine.pp.ua)
[![Build & upload to GitHub pages](https://github.com/Turskyi/Turskyi-project/actions/workflows/web_ci.yml/badge.svg)](https://github.com/Turskyi/Turskyi-project/actions/workflows/web_ci.yml)
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)
[![codecov](https://codecov.io/gh/Turskyi/Turskyi-project/graph/badge.svg?token=9AFY7V0YP4)](https://codecov.io/gh/Turskyi/Turskyi-project)
[![Code Quality](https://github.com/Turskyi/Turskyi-project/actions/workflows/code_quality_tests.yml/badge.svg)](https://github.com/Turskyi/Turskyi-project/actions/workflows/code_quality_tests.yml)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/Turskyi/Turskyi-project)
<img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/m/Turskyi/Turskyi-project">

# Developer Dmytro Turskyi landing page

The Flutter project for supporting personal website
[turskyi.com](https://turskyi.com).

## PROJECT SPECIFICATION

- Programming language: [Dart](https://dart.dev/);

- SDK: [Flutter](https://flutter.dev/);

- State management approach:
  [Provider](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple);

- Version control system: [Git](https://git-scm.com);

- Git Hosting Service: [GitHub](https://github.com);

- CI/CD: [GitHub Actions](https://docs.github.com/en/actions) is used to deploy
  the updated site to
  [GitHub Pages](https://pages.github.com/) after every push to the `master`
  branch;

- Web content hosting and a domain: [turskyi.com](https://turskyi.com);

- Generated release build https://github.com/Turskyi/turskyi.github.io;

- **Code Readability:** code is easily readable with no unnecessary blank lines,
  no unused variables
  or methods, and no commented-out code, all variables, methods, and resource
  IDs
  are descriptively
  named such that another developer reading the code can easily understand their
  function.

<details style="border: 1px solid #aaa; border-radius: 4px; padding: 0.5em 0.5em 0;">
  <summary style="font-weight: bold; margin: -0.5em -0.5em 0; padding: 0.5em; border-bottom: 1px solid #aaa;">Architectural pattern:

[Monolithic Model-View-Presenter](https://learn.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/common-web-application-architectures#what-is-a-monolithic-application)

  </summary>
<a href="https://sites.libsyn.com/412964/onion-architecture-episode-2">
<!--suppress CheckImageSize -->
<img src="documentation/monolithic_model_view_presenter.jpeg" width="800" title="Monolithic Onion Architecture" alt="Image of the Monolithic Onion Architecture Pattern">
</a>

</details>

## Screenshots:

<!--suppress CheckImageSize -->
<img src="screenshots/home.png" width="600"  alt="screenshot">
<!--suppress CheckImageSize -->
<img src="screenshots/game-2021-11-01.png" width="600" alt="screenshot" >
<!--suppress CheckImageSize -->
<img src="screenshots/phone.png" width="300" alt="screenshot">

## Contact:

For any inquiries please reach out to me directly at
[dmytro@turskyi.com](mailto:dmytro@turskyi.com).

# Disclaimer:

I am aware that building a landing page with [Flutter](https://flutter.dev/)
is not ideal due to its lack of SEO optimization and server-side rendering
support. Flutter web is more suitable for building web apps rather than
traditional websites. The current business idea of this project is a website,
which should ideally be implemented using a more appropriate framework such as
[Next.js](https://nextjs.org/). In the future, this project will be migrated
to Next.js unless Flutter starts supporting SEO optimization and server-side
rendering.



