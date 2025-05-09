from django.db import models

# Create your models here.

class Airport(models.Model):
    code = models.CharField(max_length=3)
    name = models.CharField(max_length=100)

    def __str__(self):
        return f"{self.name} ({self.code})"

class Flight(models.Model):
    from_airport = models.ForeignKey(Airport, on_delete=models.CASCADE, related_name="departures")
    to_airport = models.ForeignKey(Airport, on_delete=models.CASCADE, related_name="arrivals")
    flying_time = models.CharField(max_length=10)
    date = models.CharField(max_length=10)
    departure_time = models.CharField(max_length=10)
    number = models.IntegerField()

    def __str__(self):
        return f"Flight {self.number}: {self.from_airport.code} to {self.to_airport.code}"
