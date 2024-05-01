from django.db import models
from django.contrib.auth.models import User


def user_directory_path(instance, filename):
    # file will be uploaded to MEDIA_ROOT / user_<id>/<filename>
    return 'user_{0}/{1}'.format(instance.user.id, filename)


class ClothesLevel(models.TextChoices):
    LOW = "low"
    MIDDLE = "middle"
    HIGH = "high"


class TypeClothes(models.Model):
    name = models.CharField(max_length=255)
    type = models.CharField(choices=ClothesLevel.choices, max_length=100, default=ClothesLevel.MIDDLE)

    class Meta:
        verbose_name = "Тип одежды"
        verbose_name_plural = verbose_name


class Garderob(models.Model):
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)


class Clothes(models.Model):
    type_clothes = models.ForeignKey(TypeClothes, on_delete=models.SET_NULL, null=True)
    garderob = models.ForeignKey(Garderob, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    image = models.ImageField(upload_to=user_directory_path)