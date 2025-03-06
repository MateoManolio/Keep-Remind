abstract class IUsecase<T, P> {
  Future<T> call(P params);
}
