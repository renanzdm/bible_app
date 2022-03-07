class ConfigTable{
  static String tableName = 'configs';
  static String id = 'id';
  static String fontSizeVerse = 'font_size_verse';
  static String isDark = 'is_dark';
  static String versionBible = 'version_bible';
}

class VersesMarkedTable{
  static String tableName = 'verses_marked';
  static String id = 'id';
  static String chapterId = 'chapter_id';
  static String bookId = 'book_id';
  static String verseId = 'verse_id';
  static String colorMarked = 'color_marked';
}

class AnnotationsVersesTable{
  static String tableName = 'annotation_verses';
  static String id = 'id';
  static String fkVerseMarkedId = 'fk_verse_marked_id';
  static String annotationText = 'annotation_text';
  static String annotationAudio = 'annotation_audio';
}
