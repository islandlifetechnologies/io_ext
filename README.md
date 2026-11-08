# io_ext

Relatively simple extensions to the `dart:io` APIs. It includes:

- `DirectoryExt`: Find files matching a `Glob` pattern directly on a `Directory` instance.
- `FileSystemEntityExt`: Easy access to a file's extension and name, and the ability to resolve relative paths as strongly‑typed `File` or `Directory` objects.

## Unit Testing Support

To assist with unit testing, this package provides a top level `fs` singleton which exposes instances of `LocalFileSystem` that can easily be overridden within unit tests using `withFileSystem`.

Let's take file within the lib folder:

```dart
import 'package:io_ext/io_ext.dart';

class CodeUnderTest {
  void createSomeFile(String text) {
    final file = fs.file('temp/someFile.txt');
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync(text);
  }
}
```

You may not want `someFile.txt` to actually be created on the file system every time that function is run. In that case, you can use `withFileSystem` inside of your test.

The `withFileSystem` function allows you to run a block of code with a different `FileSystem`.

```dart
withFileSystem(MemoryFileSystem(), () {
  final cut = CodeUnderTest();
  cut.createSomeFile('hello world');

  final file = fs.file('temp/someFile.txt');
  expect(file.readAsStringSync(), 'hello world');
  expect(file.existsSync(), isTrue);
});
```
