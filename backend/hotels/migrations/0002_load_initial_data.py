from django.db import migrations

def create_initial_data(apps, schema_editor):
    Hotel = apps.get_model('hotels', 'Hotel')
    
    # Create hotels
    Hotel.objects.create(
        image='hotel_room.png',
        place='Open Space',
        destination='Oran',
        price=25
    )
    
    Hotel.objects.create(
        image='two.png',
        place='Global Will Look',
        destination='London',
        price=40
    )
    
    Hotel.objects.create(
        image='three.png',
        place='Tallest Building',
        destination='Dubai',
        price=68
    )

def delete_initial_data(apps, schema_editor):
    Hotel = apps.get_model('hotels', 'Hotel')
    Hotel.objects.all().delete()

class Migration(migrations.Migration):

    dependencies = [
        ('hotels', '0001_initial'),
    ]

    operations = [
        migrations.RunPython(create_initial_data, delete_initial_data),
    ] 