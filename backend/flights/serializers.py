from rest_framework import serializers
from .models import Airport, Flight

class AirportSerializer(serializers.ModelSerializer):
    class Meta:
        model = Airport
        fields = ['id', 'code', 'name']

class FlightSerializer(serializers.ModelSerializer):
    from_airport = AirportSerializer(read_only=True)
    to_airport = AirportSerializer(read_only=True)
    
    class Meta:
        model = Flight
        fields = ['id', 'from_airport', 'to_airport', 'flying_time', 'date', 'departure_time', 'number']
    
    def to_representation(self, instance):
        """Format the response to match the Flutter app's expected structure."""
        data = super().to_representation(instance)
        return {
            'from': {
                'code': data['from_airport']['code'],
                'name': data['from_airport']['name']
            },
            'to': {
                'code': data['to_airport']['code'],
                'name': data['to_airport']['name']
            },
            'flying_time': data['flying_time'],
            'date': data['date'],
            'departure_time': data['departure_time'],
            'number': data['number'],
        } 