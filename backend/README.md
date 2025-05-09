# FlightBook Django Backend

This is the Django backend for the FlightBook Flutter application. It provides REST API endpoints for flights and hotels data.

## Setup

1. Install dependencies:
```bash
pip install django djangorestframework django-cors-headers
```

2. Run migrations:
```bash
python manage.py makemigrations
python manage.py migrate
```

3. Start the development server:
```bash
python manage.py runserver
```

The server will start at http://127.0.0.1:8000/

## API Endpoints

### Flights
- List all flights: `GET /api/flights/`
- Get a specific flight: `GET /api/flights/{id}/`
- Create a new flight: `POST /api/flights/`
- Update a flight: `PUT /api/flights/{id}/`
- Delete a flight: `DELETE /api/flights/{id}/`

### Airports
- List all airports: `GET /api/airports/`
- Get a specific airport: `GET /api/airports/{id}/`
- Create a new airport: `POST /api/airports/`
- Update an airport: `PUT /api/airports/{id}/`
- Delete an airport: `DELETE /api/airports/{id}/`

### Hotels
- List all hotels: `GET /api/hotels/`
- Get a specific hotel: `GET /api/hotels/{id}/`
- Create a new hotel: `POST /api/hotels/`
- Update a hotel: `PUT /api/hotels/{id}/`
- Delete a hotel: `DELETE /api/hotels/{id}/`

## Integration with Flutter

The Flutter app connects to this backend using the API service. Make sure to update the base URL in the Flutter app's `api_service.dart` file to match your backend server address. 