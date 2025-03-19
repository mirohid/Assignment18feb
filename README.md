📌 Project Description

This is a SwiftUI-based News App that fetches the latest news using NewsAPI and allows users to save and delete articles using Realm database. The app also supports dark mode and provides a smooth user experience with proper state management.

🛠 Features

Fetch and display news articles using NewsAPI.
Save articles for offline viewing.
Delete saved articles
Realm for local data persistence.
Alamofire for network calls.
Dark mode support.
Clean architecture with MVVM pattern.

🚀 Setup Guide

1️⃣ Prerequisites
Ensure you have the following installed:
Xcode (latest version recommended)
CocoaPods (for dependency management)
NewsAPI Key (Get one from NewsAPI)

2️⃣ Clone the Repository
git clone https://github.com/mirohid/Assignment18feb

3️⃣ Install Dependencies
pod install
Open NewsApp.xcworkspace in Xcode.

4️⃣ Configure API Key
Replace YOUR_API_KEY_HERE in NewsAPIService.swift with your actual NewsAPI key.

5️⃣ Run the App
Press Cmd + R in Xcode to build and run the app.

📚 Libraries Used
Library
Purpose
SwiftUI
UI framework for building the app
Alamofire
Networking (fetching news)
RealmSwift
Local database for saving articles

🏗 Architecture
The app follows the MVVM (Model-View-ViewModel) pattern:
Model: Defines data structures (e.g., NewsArticle, NewsItem).
ViewModel: Handles data fetching, saving, and deletion (e.g., NewsViewModel).
View: Displays UI components (e.g., NewsListView, SavedArticlesView).

✨ Contributing
Feel free to fork the repo and submit pull requests! 😊


![1](https://github.com/user-attachments/assets/64abaf1d-9293-40be-b7f6-b8f7c84ef59d)





