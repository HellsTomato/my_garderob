from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import SeasonListAPIView, ColorsListAPIView, TypeClothesListAPIView, ClothesViewSet

router = DefaultRouter()
router.register(r'', ClothesViewSet, basename='user')

urlpatterns = [
    path("seasons-list", SeasonListAPIView.as_view(), name="seasons-list"),
    path("colors-list", ColorsListAPIView.as_view(), name="colors-list"),
    path("type-clothes-list", TypeClothesListAPIView.as_view(), name="type-clothes-list"),
]

urlpatterns += router.urls
