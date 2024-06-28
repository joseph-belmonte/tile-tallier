from rest_framework import serializers
from accounts.models import User


class AccountRegisterSerializer(serializers.ModelSerializer):
    password2 = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = User
        fields = ["email", "password", "password2", "is_subscribed"]
        extra_kwargs = {"password": {"write_only": True}}

    def validate(self, data):
        if data["password"] != data["password2"]:
            raise serializers.ValidationError({"error": "Passwords do not match"})

        if User.objects.filter(email=data["email"]).exists():
            raise serializers.ValidationError(
                {"error": "User with this email already exists"}
            )

        return data

    def create(self, validated_data):
        validated_data.pop("password2")
        user = User.objects.create_user(**validated_data)
        return user


class AccountLoginSerializer(serializers.Serializer):
    email = serializers.CharField()
    password = serializers.CharField()


class AccountInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["email", "is_subscribed"]
        read_only_fields = ["email"]
