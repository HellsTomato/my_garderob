# Generated by Django 4.2.10 on 2024-05-11 11:08

import clothes.models
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Colors',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
            ],
            options={
                'verbose_name': 'Цвета',
                'verbose_name_plural': 'Цвета',
                'db_table': 'colors',
            },
        ),
        migrations.CreateModel(
            name='Seasons',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
            ],
            options={
                'verbose_name': 'Сезоны',
                'verbose_name_plural': 'Сезоны',
                'db_table': 'seasons',
            },
        ),
        migrations.CreateModel(
            name='TypeClothes',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('level', models.CharField(choices=[('head', 'Head'), ('body', 'Body'), ('legs', 'Legs'), ('shoes', 'Shoes')], default='body', max_length=100)),
            ],
            options={
                'verbose_name': 'Тип одежды',
                'verbose_name_plural': 'Тип одежды',
                'db_table': 'type_clothes',
            },
        ),
        migrations.CreateModel(
            name='Clothes',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('image', models.ImageField(upload_to=clothes.models.user_directory_path)),
                ('colors', models.ManyToManyField(db_table='clothes_colors', related_name='colors', to='clothes.colors')),
                ('season', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='clothes.seasons')),
                ('type_clothes', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='clothes.typeclothes')),
                ('user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'Одежда',
                'verbose_name_plural': 'Одежда',
                'db_table': 'clothes',
            },
        ),
    ]
