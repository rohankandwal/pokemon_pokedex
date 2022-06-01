import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final double width, height;
  final String imageUrl;
  final BoxFit fit;
  final Widget? errorWidget;
  final Widget? placeholder;

  const NetworkImageWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.errorWidget,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: imageUrl.isEmpty
          ? _getErrorWidget()
          : CachedNetworkImage(
              imageUrl: imageUrl,
              fit: fit,
              errorWidget: (context, url, error) =>
                  errorWidget ?? _getErrorWidget(),
              placeholder: (context, url) => placeholder ?? _getPlaceHolder(),
            ),
    );
  }

  Widget _getErrorWidget() {
    return const Icon(
      Icons.error_outline,
      color: ColorConstants.mirage,
    );
  }

  Widget _getPlaceHolder() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorConstants.mirage,
      ),
    );
  }
}
