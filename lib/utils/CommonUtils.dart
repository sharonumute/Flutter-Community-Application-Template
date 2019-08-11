bool ifEmptyOrNull(String text) {
  if (text == null || text.isEmpty) {
    return true;
  }
  return false;
}

bool objectIsNotNull(Object o) => o != null;
