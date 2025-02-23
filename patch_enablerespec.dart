import 'dart:io';

void patchFile(String filePath) async {
  final file = File(filePath);

  // Lee el archivo en memoria
  var bytes = await file.readAsBytes();

  // Dirección 1: B4C2C
  bytes[0xB4C2C] = 0xEB;
  bytes[0xB4C2D] = 0x31;

  // Dirección 2: 17A238
  for (int i = 0; i < 6; i++) {
    bytes[0x17A238 + i] = 0x90; // NOP
  }

  // Dirección 3: 17A261
  for (int i = 0; i < 5; i++) {
    bytes[0x17A261 + i] = 0x90; // NOP
  }

  // Guarda los cambios en el archivo
  await file.writeAsBytes(bytes);
  print("El archivo ha sido parcheado correctamente.");
}

void main() {
  // Ruta del archivo ejecutable del juego
  String filePath = "Game.exe";

  patchFile(filePath);
}
