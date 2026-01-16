abstract interface class FavoritesServiceInterface {
  Future<List<String>> getFavorites();

  Future<void> addFavorite(String modelId);

  Future<void> removeFavorite(String modelId);
}
