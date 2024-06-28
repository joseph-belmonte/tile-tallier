from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from .serializers import (
    AccountRegisterSerializer,
    AccountLoginSerializer,
    AccountInfoSerializer,
)
from django.db import IntegrityError
from rest_framework.throttling import UserRateThrottle
from rest_framework_simplejwt.exceptions import TokenError
from accounts.models import User
from .. import permissions

from django.contrib.auth import authenticate


class AccountRegisterView(APIView):
    permission_classes = [permissions.AllowAny]
    throttle_classes = [UserRateThrottle]

    def post(self, request):
        serializer = AccountRegisterSerializer(data=request.data)
        if serializer.is_valid():
            try:
                user = serializer.save()
                return Response(
                    {"message": "User registered successfully"},
                    status=status.HTTP_201_CREATED,
                )
            except IntegrityError as e:
                if "unique constraint" in str(e) or "duplicate key" in str(e):
                    return Response(
                        {
                            "error": "An account with this email or username already exists."
                        },
                        status=status.HTTP_400_BAD_REQUEST,
                    )
                else:
                    return Response(
                        {"error": "A database error occurred."},
                        status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                    )
        else:
            # Reformat the errors to return them under a single "error" key
            errors = serializer.errors
            if "error" in errors:
                return Response(errors, status=status.HTTP_400_BAD_REQUEST)
            else:
                formatted_errors = {
                    field: " ".join(messages) for field, messages in errors.items()
                }
                return Response(
                    {"error": formatted_errors}, status=status.HTTP_400_BAD_REQUEST
                )


class AccountLoginView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        serializer = AccountLoginSerializer(data=request.data)
        if serializer.is_valid():
            user = authenticate(
                username=serializer.validated_data["email"],
                password=serializer.validated_data["password"],
            )
            if user:
                try:
                    refresh = RefreshToken.for_user(user)
                    user_data = AccountInfoSerializer(user).data
                    return Response(
                        {
                            "user": user_data,
                            "refresh": str(refresh),
                            "access": str(refresh.access_token),
                        },
                        status=status.HTTP_200_OK,
                    )
                except TokenError:
                    return Response(
                        {"error": "Unable to generate token"},
                        status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                    )
            return Response(
                {"error": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED
            )
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class AccountInfoView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        user = request.user
        return Response(
            {
                "email": user.email,
                "is_subscribed": user.is_subscribed,
            },
            status=status.HTTP_200_OK,
        )


class AccountDeleteView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def delete(self, request):
        user = request.user
        user.delete()
        return Response(
            {"message": "User deleted successfully"},
            status=status.HTTP_204_NO_CONTENT,
        )


class AccountGetAllUsersView(APIView):
    permission_classes = [permissions.IsAdmin]

    def get(self, request):
        users = User.objects.all()
        return Response(
            {
                "users": [
                    {"email": user.email, "is_subscribed": user.is_subscribed}
                    for user in users
                ]
            },
            status=status.HTTP_200_OK,
        )


class AccountDeleteAllUsersView(APIView):
    permission_classes = [permissions.IsAdmin]

    def delete(self, request):
        User.objects.all().delete()
        return Response(
            {"message": "All users deleted successfully"},
            status=status.HTTP_204_NO_CONTENT,
        )
