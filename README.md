# 🌾 SamaToll

**SamaToll** est une application mobile Flutter conçue pour la gestion agricole intelligente au Sénégal. L'application offre un tableau de bord complet pour les agriculteurs avec des fonctionnalités de surveillance météorologique, de gestion des cultures, de visualisation de données et d'assistance IA.

## 📱 Fonctionnalités

### 🏠 Tableau de bord
- Vue d'ensemble des statistiques agricoles (surface totale, nombre de cultures, température)
- Informations météorologiques en temps réel
- Carte interactive pour localiser vos parcelles
- Actions rapides vers les sections principales

### 🌤️ Météo
- Données météorologiques actuelles (température, humidité, vent)
- Prévisions météorologiques
- Intégration avec OpenWeatherMap API
- Localisation GPS automatique

### 💬 SamaToll Agent (Chat IA)
- Assistant virtuel intelligent basé sur ChatGPT/Gemini
- Réponses contextuelles pour vos questions agricoles
- Interface de chat moderne et intuitive

### 📊 Graphiques
- Visualisation des données agricoles
- Graphiques interactifs avec `fl_chart`
- Analyse des tendances et performances

### 🌱 Gestion des Cultures
- ⚠️ **En cours de développement** - Actuellement en mode statique
- Suivi de vos cultures (interface préparée)
- Informations détaillées sur chaque parcelle
- Historique et statistiques
- **Note** : Cette section n'est pas encore connectée aux données agricoles réelles. L'intégration des données collectées par l'équipe Data Science est prévue une fois le traitement de ces données terminé.

### 🔔 Notifications
- **Alertes météorologiques intelligentes** : Système d'alertes basé sur un modèle de prédiction d'humidité développé par l'équipe Data Science. Le backend analyse les données météorologiques en temps réel et envoie automatiquement une notification lorsque le seuil d'humidité critique est dépassé.
- Rappels et avertissements importants

### 🗺️ Cartes
- Intégration Google Maps
- Géolocalisation des parcelles
- Navigation et repérage

## 📊 État du Projet

### ✅ Fonctionnalités Opérationnelles
- Tableau de bord avec statistiques
- Météo en temps réel (OpenWeatherMap)
- Chat IA (SamaToll Agent) avec ChatGPT/Gemini
- Graphiques et visualisations
- **Alertes météorologiques intelligentes** : Système d'alertes automatiques basé sur un modèle de prédiction d'humidité développé par l'équipe Data Science. Le backend surveille les données météorologiques et envoie des notifications lorsque le seuil d'humidité critique est atteint.
- Cartes interactives (Google Maps)
- Géolocalisation

### 🚧 En Cours de Développement
- **Gestion des Cultures** : L'interface est prête mais fonctionne actuellement avec des données statiques. L'intégration des données agricoles réelles collectées par l'équipe Data Science est en attente du traitement de ces données.

### 🔮 À Venir
- Intégration complète des données agricoles traitées
- Analyse prédictive basée sur les données collectées
- Recommandations personnalisées pour les cultures
- Historique complet des parcelles
- Mise en place de notifications push (Firebase)


## 🛠️ Technologies Utilisées

### Frontend (Application Mobile)
- **Flutter** - Framework de développement multiplateforme
- **GetX** - Gestion d'état et navigation
- **Firebase** - Notifications push (Firebase Messaging)
- **Google Maps** - Cartes et géolocalisation
- **OpenWeatherMap API** - Données météorologiques
- **ChatGPT SDK / Google Gemini** - Intelligence artificielle
- **fl_chart** - Graphiques et visualisations
- **Geolocator** - Services de géolocalisation

### Backend & Data Science
- **Backend API** - API REST pour la gestion des données agricoles
- **Modèle de prédiction d'humidité** - Modèle de machine learning développé par l'équipe Data Science pour prédire les niveaux d'humidité et déclencher des alertes automatiques lorsqu'un seuil critique est dépassé
- **Système d'alertes intelligentes** - Architecture backend qui surveille en temps réel les données météorologiques et envoie des notifications push via Firebase

## 📋 Prérequis

Avant de commencer, assurez-vous d'avoir installé :

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.7.2 ou supérieure)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) ou [Xcode](https://developer.apple.com/xcode/) (pour iOS)
- Un compte [Firebase](https://firebase.google.com/)
- Une clé API [OpenWeatherMap](https://openweathermap.org/api)
- Une clé API OpenAI ou Google Gemini (pour le chat IA)

## 🚀 Installation

1. **Cloner le repository**
   ```bash
   git clone https://github.com/votre-username/samatoll.git
   cd samatoll
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Configurer les variables d'environnement**
   
   Créez un fichier `.env` à la racine du projet avec le contenu suivant :
   ```env
   BACKEND_API=votre_url_api_backend
   OPENAI_API_KEY=votre_clé_openai
   GEMINI_API_KEY=votre_clé_gemini
   ```

4. **Configurer Firebase**
   
   - Ajoutez vos fichiers de configuration Firebase :
     - `android/app/google-services.json` (Android)
     - `ios/Runner/GoogleService-Info.plist` (iOS)
     - `macos/Runner/GoogleService-Info.plist` (macOS)

5. **Configurer les clés API Google Maps**
   
   - Android : Ajoutez votre clé API dans `android/app/src/main/AndroidManifest.xml`
   - iOS : Ajoutez votre clé API dans `ios/Runner/AppDelegate.swift`

6. **Lancer l'application**
   ```bash
   flutter run
   ```

## 📁 Structure du Projet

```
lib/
├── const/              # Constantes de l'application
│   └── app_constants.dart
├── controller/         # Contrôleurs GetX
│   ├── chat_controller.dart
│   ├── location_controller.dart
│   ├── navigation_controller.dart
│   ├── notifications_controller.dart
│   └── weather_controller.dart
├── model/              # Modèles de données
│   ├── app_notification.dart
│   ├── forecast_weather.dart
│   └── weather.dart
├── screens/            # Écrans de l'application
│   ├── charts/         # Écrans de graphiques
│   ├── chat_screen.dart
│   ├── cultures_screen.dart
│   ├── dashboard.dart
│   ├── graphics_screen.dart
│   ├── home_screen.dart
│   └── notification_screen.dart
├── services/           # Services API
│   ├── location_service.dart
│   ├── notification_service.dart
│   └── weather_service.dart
├── widgets/            # Widgets réutilisables
│   └── my_map.dart
└── main.dart          # Point d'entrée de l'application
```

## 🔧 Configuration

### Variables d'environnement

Le projet utilise `flutter_dotenv` pour gérer les variables d'environnement. Créez un fichier `.env` avec :

- `BACKEND_API` : URL de votre API backend (utilisée pour les alertes météorologiques et les données agricoles)
- `OPENAI_API_KEY` : Clé API OpenAI pour le chat
- `GEMINI_API_KEY` : Clé API Google Gemini (alternative)

### Permissions

L'application nécessite les permissions suivantes :

- **Localisation** : Pour obtenir les données météorologiques et afficher la carte

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créez une branche pour votre fonctionnalité (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request


## 📞 Support

Pour toute question ou problème, veuillez ouvrir une [issue](https://github.com/votre-username/samatoll/issues) sur GitHub.

---

**Développé avec ❤️ pour les agriculteurs sénégalais**
