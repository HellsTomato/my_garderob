from rest_framework import serializers

from clothes.models import Seasons, Colors, TypeClothes


class SeasonsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Seasons
        fields = "__all__"


class ColorsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Colors
        fields = "__all__"


class TypeClothesSerializer(serializers.ModelSerializer):
    class Meta:
        model = TypeClothes
        fields = "__all__"
