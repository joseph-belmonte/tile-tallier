from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import GamePlay

User = get_user_model()


class UserSerializer(serializers.ModelSerializer):
    """A serializer class for the User model"""

    class Meta:
        """This class defines the metadata for the UserSerializer class"""

        model = User
        fields = ["username", "email", "password", "is_guest", "is_subscribed"]
        extra_kwargs = {"password": {"write_only": True}}

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user


class GamePlaySerializer(serializers.ModelSerializer):
    """A serializer class for the GamePlay model"""

    class Meta:
        """This class defines the metadata for the GamePlaySerializer class"""

        model = GamePlay
        fields = ["id", "user", "timestamp"]
