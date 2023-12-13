Locales['en'] = {
  ['document_deleted'] = "Dokumen telah dihapus.",
  ['document_delete_failed'] = "Gagal menghapus dokumen.",
  ['copy_from_player'] = "Anda menerima salinan dokumen.",
  ['from_copied_player'] = "Salinan dokumen berhasil diberikan.",
  ['could_not_copy_form_player'] = "Tidak dapat memberikan salinan dokumen.",
  ['document_options'] = "Spaceman Dokumen",
  ['public_documents'] = "Dokumen publik",
  ['job_documents'] = "Dokumen pekerjaan",
  ['saved_documents'] = "Dokumen tersimpan",
  ['close_bt'] = "Tutup",
  ['no_player_found'] = "Tidak ada pemain disekitar!",
  ['go_back'] = "Kembali",
  ['view_bt'] = "Lihat",
  ['show_bt'] = "Tunjukkan",
  ['give_copy'] = "Berikan salinan",
  ['delete_bt'] = "Hapus",
  ['yes_delete'] = "Lanjutkan Hapus",
}

Config.Documents['en'] = {
["public"] = {
  {
    headerTitle = "FORMULIR PERNYATAAN",
    headerSubtitle = "Formulir pernyataan warga.",
    elements = {
      { label = "ISI PERNYATAAN", type = "textarea", value = "", can_be_emtpy = false },
    }
  },
  {
    headerTitle = "FORMULIR KESAKSIAN",
    headerSubtitle = "Formulir saksi resmi.",
    elements = {
      { label = "TANGGAL KEJADIAN", type = "input", value = "", can_be_emtpy = false },
      { label = "ISI KESAKSIAN", type = "textarea", value = "", can_be_emtpy = false },
    }
  },
  {
    headerTitle = "PERNYATAAN PENGIRIMAN KENDARAAN",
    headerSubtitle = "Formulir pernyataan pengiriman kendaraan kepada warga lain.",
    elements = {
      { label = "PLAT NOMOR", type = "input", value = "", can_be_emtpy = false },
      { label = "NAMA WARGA", type = "input", value = "", can_be_emtpy = false },
      { label = "HARGA SETUJU", type = "input", value = "", can_be_empty = false },
      { label = "INFORMASI LAINNYA", type = "textarea", value = "", can_be_emtpy = true },
    }
  },
  {
    headerTitle = "SURAT PERNYATAAN UTANG TERHADAP WARGA NEGARA",
    headerSubtitle = "Surat pernyataan utang resmi terhadap warga negara lain.",
    elements = {
      { label = "NAMA DEPAN KREDITOR", type = "input", value = "", can_be_emtpy = false },
      { label = "NAMA BELAKANG KREDITOR", type = "input", value = "", can_be_emtpy = false },
      { label = "JUMLAH UTANG", type = "input", value = "", can_be_empty = false },
      { label = "TENGGAT WAKTU", type = "input", value = "", can_be_empty = false },
      { label = "INFORMASI LAINNYA", type = "textarea", value = "", can_be_emtpy = true },
    }
  },
},
["police"] = {
  {
    headerTitle = "SURAT IZIN PARKIR KHUSUS",
    headerSubtitle = "Surat Izin parkir khusus tanpa batas oleh polisi.",
    elements = {
      { label = "NAMA DEPAN PEMEGANG", type = "input", value = "", can_be_emtpy = false },
      { label = "NAMA BELAKANG PEMEGANG", type = "input", value = "", can_be_emtpy = false },
      { label = "BERLAKU HINGGA", type = "input", value = "", can_be_empty = false },
      { label = "INFORMASI", type = "textarea", value = "WARGA NEGARA TERSEBUT TELAH DIBERIKAN IZIN PARKIR TANPA BATAS DI SETIAP ZONA KOTA DAN BERLAKU SAMPAI TANGGAL BERAKHIRNYA TERSEBUT.", can_be_emtpy = false },
    }
  },
  {
    headerTitle = "SURAT IZIN SENJATA",
    headerSubtitle = "Surat Izin senjata resmi oleh polisi.",
    elements = {
      { label = "NAMA DEPAN PEMEGANG", type = "input", value = "", can_be_emtpy = false },
      { label = "NAMA BELAKANG PEMEGANG", type = "input", value = "", can_be_emtpy = false },
      { label = "BERLAKU HINGGA", type = "input", value = "", can_be_empty = false },
      { label = "INFORMASI", type = "textarea", value = "WARGA NEGARA TERSEBUT DIIZINKAN DAN DIBERIKAN IZIN SENDIRI YANG AKAN BERLAKU SAMPAI TANGGAL BERAKHIRNYA TERSEBUT.", can_be_emtpy = false },
    }
  },
  {
    headerTitle = "STNK/BPKB",
    headerSubtitle = "Surat Tanda Nomor Kendaraan resmi oleh polisi.",
    elements = {
      { label = "NAMA PANJANG", type = "input", value = "", can_be_emtpy = false },
      { label = "PLAT KENDARAAN", type = "input", value = "", can_be_emtpy = false },
      { label = "BERLAKU HINGGA", type = "input", value = "DD/MM/YYYY", can_be_empty = false },
      { label = "INFORMASI KENDARAAN", type = "textarea", value = "WARGA NEGARA TERSEBUT DIIZINKAN DAN DIBERIKAN IZIN SENDIRI YANG AKAN BERLAKU SAMPAI TANGGAL BERAKHIRNYA TERSEBUT.", can_be_emtpy = false },
    }
  },
  {
    headerTitle = "SURAT KETERANGAN CATATAN KEPOLISIAN",
    headerSubtitle = "Resmi bersih, tujuan umum, catatan kriminal warga.",
    elements = {
      { label = "NAMA DEPAN PEMEGANG", type = "input", value = "", can_be_emtpy = false },
      { label = "NAMA BELAKANG PEMEGANG", type = "input", value = "", can_be_emtpy = false },
      { label = "BERLAKU HINGGA", type = "input", value = "", can_be_empty = false },
      { label = "CATATAN", type = "textarea", value = "POLISI DENGAN INI MENYATAKAN WARGA TERSEBUT MEMILIKI REKAM PIDANA YANG (BERSIH/TIDAK). HASIL INI DIHASILKAN DARI DATA YANG DISERAHKAN DALAM SISTEM CATATAN PIDANA SETELAH TANGGAL TANDA TANGAN DOKUMEN.", can_be_emtpy = false, can_be_edited = false },
    }
  }
},
["ambulance"] = {
  {
    headerTitle = "LAPORAN MEDIS - PSIKOLOGI",
    headerSubtitle = "Laporan medis resmi yang diberikan oleh seorang psikolog.",
    elements = {
      { label = "NAMA DEPAN PASIEN", type = "input", value = "", can_be_emtpy = false },
      { label = "NAMA BELAKANG PASIEN", type = "input", value = "", can_be_emtpy = false },
      { label = "BERLAKU HINGGA", type = "input", value = "", can_be_empty = false },
      { label = "CATATAN MEDIS", type = "textarea", value = "WARGA TERTANGGUNG TERSEBUT DIUJI OLEH PEJABAT KESEHATAN DAN MENENTUKAN SEHAT JIWA OLEH STANDAR PSIKOLOGI TERENDAH YANG DISETUJUI. LAPORAN INI BERLAKU SAMPAI TANGGAL BERAKHIRNYA DI ATAS.", can_be_emtpy = false },
    }
  },
  {
    headerTitle = "LAPORAN MEDIS - SPESIALIS MATA",
    headerSubtitle = "Laporan medis resmi yang diberikan oleh spesialis mata.",
    elements = {
      { label = "NAMA DEPAN PASIEN", type = "input", value = "", can_be_emtpy = false },
      { label = "NAMA BELAKANG PASIEN", type = "input", value = "", can_be_emtpy = false },
      { label = "BERLAKU HINGGA", type = "input", value = "", can_be_empty = false },
      { label = "MEDICAL NOTES", type = "textarea", value = "WARGA TERTANGGUNG TERSEBUT DIUJI OLEH PEJABAT KESEHATAN DAN DITENTUKAN DENGAN PENGLIHATAN MATA YANG SEHAT DAN TEPAT. LAPORAN INI BERLAKU SAMPAI TANGGAL BERAKHIRNYA DI ATAS.", can_be_emtpy = false },
    }
  },
  {
    headerTitle = "LAPORAN MEDIS - BPJS",
    headerSubtitle = "Laporan medis resmi yang diberikan oleh pejabat kesehatan.",
    elements = {
      { label = "NAMA DEPAN PASIEN", type = "input", value = "", can_be_emtpy = false },
      { label = "NAMA BELAKANG PASIEN", type = "input", value = "", can_be_emtpy = false },
      { label = "BERLAKU HINGGA", type = "input", value = "DD/MM/YYYY", can_be_empty = false },
      { label = "MEDICAL NOTES", type = "textarea", value = "WARGA TERTANGGUNG TERSEBUT MEMILIKI KARTU BPJS. LAPORAN INI BERLAKU SAMPAI TANGGAL BERAKHIRNYA DI ATAS.", can_be_emtpy = false },
    }
  },
  {
    headerTitle = "LAPORAN MEDIS - SURAT KESEHATAN",
    headerSubtitle = "DENGAN INI MENYATAKAN BAHWA WARGA TERSEBUT TELAH DIUJI OLEH PETUGAS MEDIS DAN DINYATAKAN SEHAT SECARA JASMANI. HASIL PEMERIKSAAN FISIK PADA TANGGAL (DD/MM/YYYY)  DI PILLBOX HOSPITAL ADALAH SEBAGAI BERIKUT :",
    elements = {
      { label = "NAMA LENGKAP", type = "input", value = "", can_be_emtpy = false },
      { label = "BERAT BADAN", type = "input", value = " KG", can_be_emtpy = false },
      { label = "TINGGI BADAN", type = "input", value = " CM", can_be_emtpy = false },
      { label = "GOLONGAN DARAH", type = "input", value = "", can_be_empty = false },
      { label = "BERLAKU HINGGA", type = "input", value = "DD/MM/YYYY", can_be_empty = false },
      { label = "MEDICAL NOTES", type = "textarea", value = "WARGA TERTANGGUNG TERSEBUT MEMILIKI KARTU BPJS. LAPORAN INI BERLAKU SAMPAI TANGGAL BERAKHIRNYA DI ATAS.", can_be_emtpy = false },

    }
  },
}
}