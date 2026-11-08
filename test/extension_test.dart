// /Users/jpeiffer/git/ilt/io_ext/test/extension_test.dart
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:io_ext/file_ext.dart';
import 'package:test/test.dart';

void main() {
  group('DirectoryExt', () {
    late File txtFile;
    late File dartFile;

    final memfs = MemoryFileSystem();

    setUp(() async {
      txtFile = memfs.file('test/example.txt');
      txtFile.createSync(recursive: true);
      await txtFile.writeAsString('text');
      dartFile = memfs.file('test/example.dart');
      dartFile.createSync(recursive: true);
      await dartFile.writeAsString('void main() {}');
    });

    test('find<T>() returns only matching files', () {
      withFileSystem(memfs, () {
        final found = fs.currentDirectory.find<File>('**/*.txt').toList();
        expect(found, hasLength(1));
        expect(found.first.canonical.path, txtFile.canonical.path);
      });
    });
  });

  group('FileSystemEntityExt', () {
    test('extension getter works', () {
      withFileSystem(MemoryFileSystem(), () {
        final file = fs.file('path/to/file.dart');
        expect(file.extension, '.dart');
      });
    });

    test('name getter works', () {
      withFileSystem(MemoryFileSystem(), () {
        final file = fs.file('path/to/another.txt');
        expect(file.name, 'another.txt');
      });
    });
  });
}
