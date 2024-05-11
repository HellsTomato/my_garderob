import base64

from django.core.files import File
from rest_framework.generics import ListAPIView
from rest_framework.viewsets import ModelViewSet
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework import status
from clothes.filters import LevelFilter
from clothes.models import Seasons, Colors, TypeClothes, Clothes, ClothesLevel
from clothes.serializers import SeasonsSerializer, TypeClothesSerializer, ColorsSerializer, ClothesSerializer


class SeasonListAPIView(ListAPIView):
    queryset = Seasons.objects.all()
    serializer_class = SeasonsSerializer


class ColorsListAPIView(ListAPIView):
    queryset = Colors.objects.all()
    serializer_class = ColorsSerializer


class TypeClothesListAPIView(ListAPIView):
    queryset = TypeClothes.objects.all()
    serializer_class = TypeClothesSerializer
    filter_backends = [
        LevelFilter,
    ]


class ClothesViewSet(ModelViewSet):
    serializer_class = ClothesSerializer
    lookup_field = "pk"

    def get_queryset(self):
        return Clothes.objects.filter(
            user=self.request.user
        )

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

    @action(methods=["GET"], detail=False, url_path="count-of-levels")
    def count_of_levels(self, request):
        # Возвращает сколько вещей у пользователя для конкретного уровня одежды
        levels_counts = {
            level: request.user.clothes_set.filter(type_clothes__level=level).count()
            for level in ClothesLevel.values
        }
        return Response(levels_counts, status=status.HTTP_200_OK)

    @action(methods=["GET"], detail=False, url_path="count-of-clothes-types")
    def count_of_clothes_types(self, request):
        # Возвращает сколько вещей у пользователя для конкретного типа одежды
        levels_counts = {
            type_name: request.user.clothes_set.filter(type_clothes__name=type_name).count()
            for type_name in TypeClothes.objects.all().values_list('name', flat=True)
        }
        return Response(levels_counts, status=status.HTTP_200_OK)

    @action(methods=["GET"], detail=True, url_path="image-base64")
    def image_base64(self, request, *args, **kwargs):
        # Вовзращает файл в фолмате base64
        obj = self.get_object()
        with open(obj.image.path, 'rb') as f:
            image = File(f)
            data = base64.b64encode(image.read())
        return Response(data, status=status.HTTP_200_OK)
