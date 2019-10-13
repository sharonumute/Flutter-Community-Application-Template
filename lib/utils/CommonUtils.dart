bool ifObjectIsNotNull(Object o) => o != null;

bool ifStringEmptyOrNull(String text) {
  if (text == null || text.isEmpty) {
    return true;
  }
  return false;
}
