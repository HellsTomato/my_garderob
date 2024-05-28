from django.urls import path

from .views import RegisterAPIView, logout_user
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path("register", RegisterAPIView.as_view(), name="register"),
    path("login", obtain_auth_token, name="login"),
    path('logout', logout_user, name="logout")
]