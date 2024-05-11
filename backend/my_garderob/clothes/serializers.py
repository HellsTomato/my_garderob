from rest_framework import serializers

from clothes.models import Seasons, Colors, TypeClothes, Clothes


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


class ClothesSerializer(serializers.ModelSerializer):

    class Meta:
        model = Clothes
        fields = "__all__"

    def prepare_user(self):
        if user := self.context['request'].user:
            self.initial_data['user'] = user.id
            return True
        return False
