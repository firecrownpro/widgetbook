class BuildReadyRequest {
  const BuildReadyRequest({
    required this.apiKey,
    required this.buildId,
  });

  final String apiKey;
  final String buildId;

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'buildId': buildId,
    };
  }
}
