# FlightBook App Enhancements

## New Features Added

### 1. Django Backend Integration
- Created a Django backend with REST API endpoints for flights, hotels, and user authentication
- Added models for Airport, Flight, and Hotel
- Implemented token-based authentication
- Set up API endpoints for user registration and login

### 2. Flight Details Screen
- Added a detailed view for flight tickets
- Shows comprehensive flight information
- Includes a button to proceed to payment

### 3. Payment System
- Created a payment screen with credit card form
- Added form validation for payment details
- Implemented a success screen after payment

### 4. User Authentication
- Added login and registration screens
- Implemented token-based authentication
- Created a profile screen with user information
- Added logout functionality

### 5. Hotel Booking System
- Enhanced hotel details screen with comprehensive information
- Added room selection functionality with different room types
- Implemented date picker for check-in and check-out
- Added booking summary and price calculation
- Integrated with the payment system

## How to Use

### Running the Backend
1. Navigate to the backend directory:
```
cd backend
```

2. Run the server:
```
run_server.bat
```
or
```
python manage.py runserver
```

### Running the Flutter App
1. Make sure you have all dependencies:
```
flutter pub get
```

2. Run the app:
```
flutter run
```

## API Endpoints

- User Registration: `POST /api/auth/register/`
- User Login: `POST /api/auth/login/`
- User Profile: `GET /api/auth/user/`
- Flights: `GET /api/flights/`
- Hotels: `GET /api/hotels/`

## Authentication Flow

1. User registers or logs in
2. Backend returns an authentication token
3. App stores the token in SharedPreferences
4. Token is included in subsequent API requests
5. User can log out, which clears the token 