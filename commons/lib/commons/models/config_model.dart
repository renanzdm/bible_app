

import '../utils/tables_info.dart';

class ConfigModel {
  final int id;
  final num fontSizeVerse;
  final bool isDark;
  final String versionBible;

  const ConfigModel({
     this.id = -1,
     this.fontSizeVerse = 12.0,
     this.isDark=false,
    this.versionBible = 'pt_nvi'
  });

  Map<String, dynamic> toMap() {
    return {
      if(id != -1) ConfigTable.id: id,
      ConfigTable.fontSizeVerse: fontSizeVerse,
      ConfigTable.isDark: isDark == false ? 0 : 1,
      ConfigTable.versionBible:versionBible
    };
  }

  factory ConfigModel.fromMap(Map<String, dynamic> map) {
    return ConfigModel(
      id: map[ConfigTable.id] ?? -1,
      fontSizeVerse: map[ConfigTable.fontSizeVerse] ?? 12.0,
      isDark: map[ConfigTable.isDark] == 0 ? false : true,
      versionBible: map[ConfigTable.versionBible] ?? ''
    );
  }

  ConfigModel copyWith({
    int? id,
    double? fontSizeVerse,
    bool? isDark,
    String? versionBible,
  }) {
    return ConfigModel(
      id: id ?? this.id,
      fontSizeVerse: fontSizeVerse ?? this.fontSizeVerse,
      isDark: isDark ?? this.isDark,
      versionBible: versionBible ?? this.versionBible,
    );
  }
}
