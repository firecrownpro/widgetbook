import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/app_info/app_info.dart';
import 'package:widgetbook/src/app_info/app_info_provider.dart';
import 'package:widgetbook/src/builder/builder.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
import 'package:widgetbook/src/navigation/organizer_state.dart';
import 'package:widgetbook/src/navigation/preview_provider.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';
import 'package:widgetbook/src/utils/styles.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

/// Describes the configuration for your [Widget] library.
///
/// [Widgetbook] is the central element in organizing your widgets into
/// Folders and UseCases.
/// In addition, [Widgetbook] allows you to specify
/// - the [Theme]s used by your application,
/// - the [Device]s on which you'd like to preview the catalogued widgets
/// - the [Locale]s used by your application
///
/// [Widgetbook] defines the following constructors for different themes
/// - [Widgetbook]<[CustomTheme]> if you use a [CustomTheme] for your app
/// - [Widgetbook.cupertino] if you use [CupertinoThemeData] for your app
/// - [Widgetbook.material] if you use [ThemeData] for your app
///
/// Note: if you use for instance both [CupertinoThemeData] and [ThemeData] in
/// your app, use the [Widgetbook]<[CustomTheme]> constructor with [CustomTheme]
/// set to [dynamic] or [Object] and see [ThemeBuilderFunction] for how to
/// render custom themes.
class Widgetbook<CustomTheme> extends StatefulWidget {
  const Widgetbook({
    super.key,
    required this.categories,
    required this.appInfo,
    this.appBuilder = defaultAppBuilder,
    required this.addons,
  }) : assert(
          categories.length > 0,
          'Please specify at least one $WidgetbookCategory.',
        );

  final List<WidgetbookAddOn> addons;

  /// Categories which host Folders and WidgetElements.
  /// This can be used to organize the structure of the Widgetbook on a large
  /// scale.
  final List<WidgetbookCategory> categories;

  /// Information about the app that is catalogued in the Widgetbook.
  final AppInfo appInfo;

  final AppBuilderFunction appBuilder;

  /// A [Widgetbook] which uses cupertino theming via [CupertinoThemeData].
  static Widgetbook<CupertinoThemeData> cupertino({
    required List<WidgetbookCategory> categories,
    required List<WidgetbookTheme<CupertinoThemeData>> themes,
    required AppInfo appInfo,
    required List<WidgetbookAddOn> addons,
    List<Device>? devices,
    List<WidgetbookFrame>? frames,
    List<Locale>? supportedLocales,
    List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    AppBuilderFunction? appBuilder,
    List<double>? textScaleFactors,
    Key? key,
  }) {
    return Widgetbook<CupertinoThemeData>(
      key: key,
      categories: categories,
      appInfo: appInfo,
      addons: addons,
      appBuilder: appBuilder ?? cupertinoAppBuilder,
    );
  }

  /// A [Widgetbook] which uses material theming via [ThemeData].
  static Widgetbook<ThemeData> material({
    required List<WidgetbookCategory> categories,
    required AppInfo appInfo,
    required List<WidgetbookAddOn> addons,
    AppBuilderFunction? appBuilder,
    Key? key,
  }) {
    return Widgetbook<ThemeData>(
      key: key,
      categories: categories,
      appInfo: appInfo,
      addons: addons,
      appBuilder: appBuilder ?? materialAppBuilder,
    );
  }

  @override
  State<Widgetbook<CustomTheme>> createState() =>
      _WidgetbookState<CustomTheme>();
}

class _WidgetbookState<CustomTheme> extends State<Widgetbook<CustomTheme>> {
  final StoryRepository storyRepository = StoryRepository();
  final SelectedStoryRepository selectedStoryRepository =
      SelectedStoryRepository();

  late BuilderProvider builderProvider;
  late OrganizerProvider organizerProvider;
  late PreviewProvider previewProvider;
  late AppInfoProvider appInfoProvider;
  late KnobsNotifier knobsNotifier;
  late GoRouter goRouter;

  @override
  void initState() {
    builderProvider = BuilderProvider(appBuilder: widget.appBuilder);
    organizerProvider = OrganizerProvider(
      state: OrganizerState.unfiltered(categories: widget.categories),
      storyRepository: storyRepository,
    )..hotReload(widget.categories);
    previewProvider = PreviewProvider(
      storyRepository: storyRepository,
      selectedStoryRepository: selectedStoryRepository,
    );
    knobsNotifier = KnobsNotifier(selectedStoryRepository);
    appInfoProvider = AppInfoProvider(state: widget.appInfo);

    goRouter = createRouter(
      previewProvider: previewProvider,
    );

    super.initState();
  }

  @override
  void didUpdateWidget(covariant Widgetbook<CustomTheme> oldWidget) {
    organizerProvider.hotReload(widget.categories);
    appInfoProvider.hotReload(widget.appInfo);
    builderProvider.hotReload(appBuilder: widget.appBuilder);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: knobsNotifier),
        ChangeNotifierProvider.value(value: organizerProvider),
        ChangeNotifierProvider.value(value: previewProvider),
        ChangeNotifierProvider.value(value: appInfoProvider),
        ChangeNotifierProvider(create: (context) => builderProvider),
        ChangeNotifierProvider(
          create: (_) => AddOnProvider(widget.addons),
        ),
      ],
      child: MaterialApp.router(
        routeInformationProvider: goRouter.routeInformationProvider,
        routeInformationParser: goRouter.routeInformationParser,
        routerDelegate: goRouter.routerDelegate,
        title: widget.appInfo.name,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        darkTheme: Styles.darkTheme,
        theme: Styles.lightTheme,
      ),
    );
  }
}
