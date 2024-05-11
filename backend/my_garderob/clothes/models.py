from django.db import models
from django.contrib.auth.models import User


def user_directory_path(instance, filename):
    # file will be uploaded to MEDIA_ROOT / user_<id>/<filename>
    return 'user_{0}/{1}'.format(instance.user.id, filename)


class Seasons(models.Model):
    name = models.CharField(max_length=255)

    class Meta:
        verbose_name = "Сезоны"
        verbose_name_plural = verbose_name
        db_table = "seasons"


class Colors(models.Model):
    name = models.CharField(max_length=255)

    class Meta:
        verbose_name = "Цвета"
        verbose_name_plural = verbose_name
        db_table = "colors"


class ClothesLevel(models.TextChoices):
    HEAD = "head"
    BODY = "body"
    LEGS = "legs"
    SHOES = "shoes"


class TypeClothes(models.Model):
    name = models.CharField(max_length=255)
    level = models.CharField(choices=ClothesLevel.choices, max_length=100, default=ClothesLevel.BODY)

    class Meta:
        verbose_name = "Тип одежды"
        verbose_name_plural = verbose_name
        db_table = "type_clothes"


class Clothes(models.Model):
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    type_clothes = models.ForeignKey(TypeClothes, on_delete=models.SET_NULL, null=True, blank=True)
    name = models.CharField(max_length=255)
    image = models.ImageField(upload_to=user_directory_path)
    colors = models.ManyToManyField(to=Colors, related_name="colors", db_table="clothes_colors")
    season = models.ForeignKey(Seasons, on_delete=models.SET_NULL, null=True, blank=True)

    class Meta:
        verbose_name = "Одежда"
        verbose_name_plural = verbose_name
        db_table = "clothes"
