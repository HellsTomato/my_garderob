from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from .serializers import UserSerializer
from django.contrib.auth.models import User
from rest_framework.decorators import authentication_classes, permission_classes


@authentication_classes([])
@permission_classes([])
class RegisterAPIView(APIView):
    """
    Апи для регистрации. Возвращает логин и созданный токен
    """

    def post(self, request, *args, **kwargs):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = User.objects.create_user(
                **serializer.validated_data
            )
            token = Token.objects.create(user=user)
            return Response({'username': user.username, "token": token.key}, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["POST", ])
def logout_user(request):
    # Выход из системы (удаляем токен)
    request.user.auth_token.delete()
    return Response({"message": "You are logged out"}, status=status.HTTP_200_OK)
