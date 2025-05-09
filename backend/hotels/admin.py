from django.contrib import admin
from .models import Hotel

@admin.register(Hotel)
class HotelAdmin(admin.ModelAdmin):
    list_display = ('place', 'destination', 'price')
    list_filter = ('destination',)
    search_fields = ('place', 'destination')
