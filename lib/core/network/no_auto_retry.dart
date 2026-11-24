/// Riverpod 3 reintenta solo los providers que fallan (con espera
/// creciente). La app no lo quiere: los errores de red/5xx se muestran y el
/// usuario reintenta a mano (CLAUDE.md §5). Se pasa a `ProviderScope.retry`.
Duration? noAutoRetry(int retryCount, Object error) => null;
