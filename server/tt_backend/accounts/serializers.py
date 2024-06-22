# accounts/serializers.py
from rest_framework import serializers
from .models import CustomUser, GamePlay


class UserSerializer(serializers.ModelSerializer):
    password2 = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = CustomUser
        fields = ["email", "password", "password2", "is_subscribed", "purchases"]
        extra_kwargs = {"password": {"write_only": True}}

    def validate(self, data):
        if data["password"] != data["password2"]:
            raise serializers.ValidationError("Passwords do not match")
        return data

    def create(self, validated_data):
        validated_data.pop("password2")
        user = CustomUser.objects.create_user(**validated_data)
        return user


class GamePlaySerializer(serializers.ModelSerializer):
    class Meta:
        model = GamePlay
        fields = ["id", "user", "timestamp"]