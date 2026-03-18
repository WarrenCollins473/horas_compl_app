enum AppRoutes { hours, documents, pdf }

extension AppRouteExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.hours:
        return '/hours';
      case AppRoutes.documents:
        return '/documents';
      case AppRoutes.pdf:
        return '/pdf';
    }
  }
}
