from django.contrib.auth import get_user_model

from rest_framework import serializers
from rest_framework.authtoken.admin import User


class UserSerializer(serializers.ModelSerializer):
    class Meta:        #мета класс в котором прописанно в какой модели мы работаем и с какими полями
        model = User
        fields = ['email', 'username', 'password']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data): #правила создания новых записей  при post def create при put def create
        user = User(
            email=validated_data['email'],
            username=validated_data['username']
        )
        user.set_password(validated_data['password']) #хеширует пароль
        user.save() #сохраняет юзера
        return user
