from rest_framework.generics import ListAPIView
from rest_framework.viewsets import ModelViewSet
from rest_framework.response import Response
from rest_framework import status
from clothes.filters import LevelFilter
from clothes.models import Seasons, Colors, TypeClothes, Clothes
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
        serializer.prepare_user()
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
