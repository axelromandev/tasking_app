import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'tasks_provider.dart';

final backupProvider =
    StateNotifierProvider.autoDispose<_Notifier, bool>((ref) {
  final onSelectList = ref.read(tasksProvider.notifier).onSelectListTasks;
  return _Notifier(onSelectList);
});

class _Notifier extends StateNotifier<bool> {
  _Notifier(this.onSelectList) : super(false);

  final void Function(ListTasks) onSelectList;

  // final _groupRepository = GroupRepository();
  // final now = DateTime.now();

  Future<void> exportToDevice() async {
    // state = true;
    // final directory = await getApplicationDocumentsDirectory();
    // final fileJson = File('${directory.path}/backup.json');
    // final zipFile =
    //     File('${directory.path}/tasking_backup_${now.toString()}.zip');
    // try {
    //   final jsonString = await _localRepository.export();
    //   await fileJson.writeAsString(jsonString);
    //   await ZipFile.createFromDirectory(
    //     sourceDir: Directory(fileJson.path),
    //     zipFile: zipFile,
    //     recurseSubDirs: true,
    //   );
    //   await Share.shareXFiles([XFile(zipFile.path)], subject: 'Backup Tasking');
    // } finally {
    //   await fileJson.delete();
    //   await zipFile.delete();
    //   state = false;
    // }
  }

  Future<void> importFromDevice() async {
    // state = true;
    // File? fileJson;
    // try {
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     allowedExtensions: ['zip'],
    //     type: FileType.custom,
    //   );
    //   if (result == null) return;
    //   final directory = await getApplicationDocumentsDirectory();
    //   fileJson = File('${directory.path}/backup.json');
    //   final exists = await fileJson.exists();
    //   if (exists) {
    //     await fileJson.delete();
    //   }
    //   await ZipFile.extractToDirectory(
    //     zipFile: File(result.files.single.path!),
    //     destinationDir: directory,
    //   );
    //   final jsonString = await fileJson.readAsString();
    //   await _localRepository.import(jsonString);
    //   final groups = await _groupRepository.fetchAll();
    //   final group = groups.firstWhere((element) => element.id == 1);
    //   onSelectGroup(group);
    // } finally {
    //   fileJson?.delete();
    //   state = false;
    // }
  }
}
