# Generated by Django 4.2.10 on 2024-05-11 12:12

from django.db import migrations


def fill_seasons(app_model, schema_editor):
    Seasons = app_model.get_model('clothes', 'Seasons')
    seasons = (
        "Winter",
        "Spring",
        "Summer",
        "Autumn",
        "Multi-Season",
    )

    Seasons.objects.bulk_create(
        Seasons(
            name=season_name
        ) for season_name in seasons
    )


class Migration(migrations.Migration):
    dependencies = [
        ('clothes', '0002_fill_colors'),
    ]

    operations = [
        migrations.RunPython(fill_seasons)
    ]
