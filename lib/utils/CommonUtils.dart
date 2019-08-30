bool ifEmptyOrNull(String text) {
  if (text == null || text.isEmpty) {
    return true;
  }
  return false;
}

bool ifObjectIsNotNull(Object o) => o != null;
