class SampleProject {
  final String title;
  final String description;
  final String mediaType;
  final String? imageUrl;
  final String? videoUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? demoUrl;

  const SampleProject({
    required this.title,
    required this.description,
    required this.mediaType,
    this.imageUrl,
    this.videoUrl,
    this.technologies = const [],
    this.githubUrl,
    this.demoUrl,
  });
}