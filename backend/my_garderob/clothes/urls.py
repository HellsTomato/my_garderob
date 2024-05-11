from django.urls import path
from .views import SeasonListAPIView, ColorsListAPIView, TypeClothesListAPIView

urlpatterns = [
    path("seasons-list", SeasonListAPIView.as_view(), name="seasons-list"),
    path("colors-list", ColorsListAPIView.as_view(), name="colors-list"),
    path("type-clothes-list", TypeClothesListAPIView.as_view(), name="type-clothes-list"),
]