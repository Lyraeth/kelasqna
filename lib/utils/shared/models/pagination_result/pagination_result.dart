class PaginatedResult<T> {
  final List<T> data;
  final int currentPage;
  final int totalPages;

  const PaginatedResult({
    required this.data,
    required this.currentPage,
    required this.totalPages,
  });
}
