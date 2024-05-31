class Constants {
  // static String apiBaseUrl = "http://localhost:5000/";
  //! Attention: Pour les émulateurs Android, utiliser la ligne suivante
  static String apiBaseUrl = "http://10.0.2.2:5000";

  /* ----------- Authentification ---------- */
  static String uriAuthentification = "$apiBaseUrl/auth/login";

  /* ---------------- Tables --------------- */
  static String uriUsers = "$apiBaseUrl/users";
  static String uriProfiles = "$apiBaseUrl/profile";
  static String uriAddresses = "$apiBaseUrl/addresses";
}
