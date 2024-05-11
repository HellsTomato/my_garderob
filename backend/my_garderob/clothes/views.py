from rest_framework.generics import ListAPIView

from clothes.filters import LevelFilter
from clothes.models import Seasons, Colors, TypeClothes
from clothes.serializers import SeasonsSerializer, TypeClothesSerializer, ColorsSerializer


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