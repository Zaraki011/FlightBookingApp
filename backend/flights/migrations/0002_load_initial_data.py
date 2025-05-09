from django.db import migrations

def create_initial_data(apps, schema_editor):
    Airport = apps.get_model('flights', 'Airport')
    Flight = apps.get_model('flights', 'Flight')
    
    # Create airports
    orn = Airport.objects.create(code="ORN", name="Oran")
    dxb = Airport.objects.create(code="DXB", name="Dubai")
    alg = Airport.objects.create(code="ALG", name="Algers")
    san = Airport.objects.create(code="SAN", name="Shanghai")
    rtd = Airport.objects.create(code="RTD", name="Algers")
    sdf = Airport.objects.create(code="SDF", name="Shanghai")
    srf = Airport.objects.create(code="SRF", name="Algers")
    vfg = Airport.objects.create(code="VFG", name="Shanghai")
    
    # Create flights
    Flight.objects.create(
        from_airport=orn,
        to_airport=dxb,
        flying_time='9H 30M',
        date='01 FEB',
        departure_time='07:00 AM',
        number=19
    )
    
    Flight.objects.create(
        from_airport=alg,
        to_airport=san,
        flying_time='4H 20M',
        date='10 MAY',
        departure_time='09:00 AM',
        number=45
    )
    
    Flight.objects.create(
        from_airport=rtd,
        to_airport=sdf,
        flying_time='4H 20M',
        date='10 MAY',
        departure_time='09:00 AM',
        number=45
    )
    
    Flight.objects.create(
        from_airport=srf,
        to_airport=vfg,
        flying_time='4H 20M',
        date='10 MAY',
        departure_time='09:00 AM',
        number=45
    )

def delete_initial_data(apps, schema_editor):
    Airport = apps.get_model('flights', 'Airport')
    Flight = apps.get_model('flights', 'Flight')
    
    Flight.objects.all().delete()
    Airport.objects.all().delete()

class Migration(migrations.Migration):

    dependencies = [
        ('flights', '0001_initial'),
    ]

    operations = [
        migrations.RunPython(create_initial_data, delete_initial_data),
    ] 