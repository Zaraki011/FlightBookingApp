from django.contrib import admin
from .models import Airport, Flight

@admin.register(Airport)
class AirportAdmin(admin.ModelAdmin):
    list_display = ('code', 'name')
    search_fields = ('code', 'name')

@admin.register(Flight)
class FlightAdmin(admin.ModelAdmin):
    list_display = ('number', 'from_airport', 'to_airport', 'date', 'flying_time')
    list_filter = ('date',)
    search_fields = ('number', 'from_airport__code', 'to_airport__code')
