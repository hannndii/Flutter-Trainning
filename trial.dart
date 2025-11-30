void main() {
  int baris = 3;
  int kolom = 2;

  print("Matriks $baris x $kolom");
  print("Isi matriks:");

  int nilai = 1;
  for (int i = 0; i < baris; i++) {
    String matrix = "";
    for (int j = 0; j < kolom; j++) {
      matrix += "$nilai ";
      nilai++;
    }
    print(matrix);
  }

  print("\nHasil transpose:");
  for (int i = 0; i < kolom; i++) {
    String matrix = "";
    for (int j = 0; j < baris; j++) {
      int elemen = (j * kolom) + (i + 1);
      matrix += "$elemen ";
    }
    print(matrix);
  }
}