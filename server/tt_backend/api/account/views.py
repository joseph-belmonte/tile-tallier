from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from .serializers import AccountRegisterSerializer, AccountLoginSerializer
from django.contrib.auth import authenticate


class AccountRegisterView(APIView):
    def post(self, request):
        serializer = AccountRegisterSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            return Response(
                {"message": "User registered successfully"},
                status=status.HTTP_201_CREATED,
            )
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class AccountLoginView(APIView):
    def post(self, request):
        serializer = AccountLoginSerializer(data=request.data)
        if serializer.is_valid():
            user = authenticate(
                username=serializer.data["username"],
                password=serializer.data["password"],
            )
            if user:
                refresh = RefreshToken.for_user(user)
                return Response(
                    {
                        "refresh": str(refresh),
                        "access": str(refresh.access_token),
                    },
                    status=status.HTTP_200_OK,
                )
            return Response(
                {"error": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED
            )
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class AccountInfoView(APIView):
    def get(self, request):
        user = request.user
        if user.is_authenticated:
            return Response(
                {
                    "email": user.email,
                    "is_subscribed": user.is_subscribed,
                },
                status=status.HTTP_200_OK,
            )
        return Response(
            {"error": "User not authenticated"},
            status=status.HTTP_400_BAD_REQUEST,
        )


class AccountDeleteView(APIView):
    def delete(self, request):
        user = request.user
        user.delete()
        return Response(
            {"message": "User deleted successfully"},
            status=status.HTTP_204_NO_CONTENT,
        )
