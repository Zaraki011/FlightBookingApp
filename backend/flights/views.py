from django.shortcuts import render
from rest_framework import viewsets
from .models import Airport, Flight
from .serializers import AirportSerializer, FlightSerializer

# Create your views here.

class AirportViewSet(viewsets.ModelViewSet):
    queryset = Airport.objects.all()
    serializer_class = AirportSerializer

class FlightViewSet(viewsets.ModelViewSet):
    queryset = Flight.objects.all()
    serializer_class = FlightSerializer
