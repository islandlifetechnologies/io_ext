import 'package:file/file.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

extension DirectoryExt on Directory {
  Directory get canonical => fileSystem.directory(p.canonicalize(path));

  /// Returns an iterable of entities matching the [glob].
  Iterable<T> find<T>(
    String glob, {
    bool? caseSensitive,
    bool recursive = true,
  }) => Glob(
    glob,
    caseSensitive: caseSensitive,
    recursive: recursive,
  ).listFileSystemSync(fileSystem, root: canonicalPath).whereType<T>();
}

extension FileExt on File {
  File get canonical => fileSystem.file(p.canonicalize(path));
}

extension FileSystemEntityExt on FileSystemEntity {
  /// Canonicalizes [path].
  ///
  /// This is guaranteed to return the same path for two different input paths
  /// if and only if both input paths point to the same location. Unlike
  /// [normalize], it returns absolute paths when possible and canonicalizes
  /// ASCII case on Windows.
  ///
  /// Note that this does not resolve symlinks.
  String get canonicalPath => p.canonicalize(path);

  /// Gets the file extension of [path]: the portion of [basename] from the last
  /// `.` to the end (including the `.` itself).
  String get extension => p.extension(path);

  /// Gets the part of [path] after the last separator.
  String get name => p.basename(path);
}
