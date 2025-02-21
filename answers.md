# Answers for Technical Questions

## 1. Timezone Conflicts: How would you handle timezone conflicts between participants in an appointment? 
Answers : Untuk mengatasi konflik zona waktu antar peserta, sistem menerapkan langkah-langkah berikut:

  - **Setiap user harus memilih timezone saat registrasi**  
     - Saat user mendaftar, mereka harus mengisi **preferred_timezone** yang diambil dari:
     ```php
     $timezones = DateTimeZone::listIdentifiers(); - Zona waktu ini akan disimpan di database.
  - Saat membuat appointment, waktu disimpan dalam timezone pembuat (creator), User yang membuat appointment menentukan jam dalam timezone-nya sendiri.
  - Saat menambahkan peserta (users lain), sistem mengecek apakah waktu appointment masih dalam jam kerja mereka (09:00 - 17:00)
     Waktu appointment dikonversi ke timezone masing-masing user sebelum ditambahkan.
     Di Laravel, ini bisa dilakukan menggunakan Carbon:
        foreach ($users as $user) {
            $userTz = new CarbonTimeZone($user->preferred_timezone ?? 'UTC'); // Default ke UTC jika null
        
            // Konversi waktu appointment ke timezone user
            $startUserTz = Carbon::parse($appointment->start, $creatorTz)->setTimezone($userTz);
            $endUserTz = Carbon::parse($appointment->end, $creatorTz)->setTimezone($userTz);
        
            // Validasi apakah masih dalam jam kerja (09:00 - 17:00)
            if ($startUserTz->format('H:i') >= '09:00' && $startUserTz->format('H:i') <= '17:00' &&
                $endUserTz->format('H:i') >= '09:00' && $endUserTz->format('H:i') <= '17:00') {
                $availableUsers[] = $user;
            }
        }
  Jadi Keuntungan Pendekatan Ini :
    1. Setiap user melihat waktu appointment dalam timezone mereka sendiri.
    2. Janji temu hanya dapat dibuat jika semua peserta berada dalam jam kerja masing-masing.
    3. Memastikan tidak ada konflik waktu antar peserta dari zona waktu berbeda.

## 2. Database Optimization: How can you optimize database queries to efficiently fetch user-specific appointments?
Answers : Gunakan select() untuk Mengambil Data yang Diperlukan Saja ->select('id', 'title', 'start', 'end', 'creator_id'), Gunakan pluck() dengan Benar, 

## 3. Additional Features: If this application were to become a real product, what additional features would you implement? Why? 
  Answers : Jika aplikasi ini dikembangkan lebih lanjut, beberapa fitur tambahan yang bisa ditambahkan adalah:

    1. Notifikasi & Reminder - Kirim email atau push notification sebagai pengingat janji temu.

    2.Integrasi dengan Google Calendar - Sinkronisasi janji temu dengan Google Calendar agar lebih mudah dikelola.

    3. Role-Based Access Control (RBAC) - Tambahkan peran pengguna seperti admin, manager, dan client untuk membatasi akses fitur tertentu.

## 4. Session Management: How would you manage user sessions securely while keeping them lightweight (e.g., avoiding large JWT payloads)?
Answers :

    1. Batasi Waktu Session - Session otomatis expired setelah 60 menit tanpa aktivitas, yang diatur di .env: SESSION_LIFETIME=60

    2. Regenerasi Session Saat Login, Menggunakan session()->regenerate() saat user login untuk mencegah Session Hijacking:
          Auth::login($user);
          session()->regenerate();

    3. Hapus Session Saat Logout , Saat user logout, session harus dihapus dan token harus diregenerasi:
    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect('/login')->with('message', 'Anda telah logout.');
    }
