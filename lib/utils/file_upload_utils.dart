import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import '../data/create_fileStructure.dart';
import '../data/file_class.dart';
final uuid = Uuid();

String getFileIcon(String? extension) {
  switch (extension?.toLowerCase()) {
    case "pdf":
      return "assets/pdf-file.svg";
    case "png":
    case "jpg":
    case "jpeg":
      return "assets/png-file.svg";
    case "txt":
      return "assets/file-file.svg";
    case "xlsx":
    case "xls":
      return "assets/excel-file.svg";
    default:
      return "assets/default-file.svg";
  }
}

List<FileItemNew> processFiles(List<PlatformFile> files, bool isFolderUpload, String folderName) {
  return files.map((file) {
    return FileItemNew(
      name: file.name,
      icon: getFileIcon(file.extension),
      isFolder: false,
      isStarred: false,
      filePath: file.path,
      identifier: uuid.v4(),
    );
  }).toList();
}