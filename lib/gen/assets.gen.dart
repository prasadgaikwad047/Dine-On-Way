/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  $AssetsIconAmenitiesGen get amenities => const $AssetsIconAmenitiesGen();
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/img 1.jpg
  AssetGenImage get img1 => const AssetGenImage('assets/image/img 1.jpg');

  /// File path: assets/image/img 2.jpg
  AssetGenImage get img2 => const AssetGenImage('assets/image/img 2.jpg');

  /// File path: assets/image/img 3.jpg
  AssetGenImage get img3 => const AssetGenImage('assets/image/img 3.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [img1, img2, img3];
}

class $AssetsIconAmenitiesGen {
  const $AssetsIconAmenitiesGen();

  /// File path: assets/icon/amenities/booking.svg
  String get booking => 'assets/icon/amenities/booking.svg';

  /// File path: assets/icon/amenities/chevron-left.svg
  String get chevronLeft => 'assets/icon/amenities/chevron-left.svg';

  /// File path: assets/icon/amenities/home.svg
  String get home => 'assets/icon/amenities/home.svg';

  /// File path: assets/icon/amenities/like.svg
  String get like => 'assets/icon/amenities/like.svg';

  /// File path: assets/icon/amenities/location.svg
  String get location => 'assets/icon/amenities/location.svg';

  /// File path: assets/icon/amenities/map.svg
  String get map => 'assets/icon/amenities/map.svg';

  /// File path: assets/icon/amenities/profile.svg
  String get profile => 'assets/icon/amenities/profile.svg';

  /// List of all assets
  List<String> get values =>
      [booking, chevronLeft, home, like, location, map, profile];
}

class Assets {
  Assets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImageGen image = $AssetsImageGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
