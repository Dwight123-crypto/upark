# upark

# Developer Setup for Google Maps API Key

To set up this project with the Google Maps API key, follow these steps:

1. **Create a `.env` file:**

   - In the project root, create a file named `.env`
   - Add the following line to it:
     ```
     GOOGLE_MAPS_API_KEY=your_actual_api_key_here
     ```
   - Replace `your_actual_api_key_here` with the actual Google Maps API key
   - **Note:** Never commit this file to version control

2. **Install dependencies:**

   - Run `flutter pub get` to install all required dependencies

3. **Create placeholder files:**

   - Create `android/app/src/main/res/values/strings.xml` with the content:
     ```xml
     <?xml version="1.0" encoding="utf-8"?>
     <resources>
       <string name="google_maps_api_key">YOUR_API_KEY_PLACEHOLDER</string>
     </resources>
     ```
   - Ensure `ios/Runner/AppDelegate.swift` exists with the placeholder:
     ```swift
     GMSServices.provideAPIKey("YOUR_API_KEY_PLACEHOLDER")
     ```

4. **Make the setup script executable:**

   - Run `chmod +x setup_api_keys.sh` in the project root

5. **Run the setup script:**

   - Execute `./setup_api_keys.sh` in the project root
   - This replaces placeholders with the actual API key from `.env`

6. **Build and run the app:**
   - Now you can build and run the app with `flutter run`

## Important Notes:

- Never commit the `.env` file or any file containing the actual API key
- Run `setup_api_keys.sh` after pulling updates or when the API key changes
- Keep the API key confidential and do not share it outside the development team

If you encounter any issues, please contact the project lead.
