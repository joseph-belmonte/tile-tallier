# accounts/views.py
from rest_framework import generics, permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.views import TokenObtainPairView
from .models import User, GamePlay, Purchase
from .serializers import UserSerializer, GamePlaySerializer


class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    permission_classes = [permissions.AllowAny]
    serializer_class = UserSerializer


class LoginView(TokenObtainPairView):
    permission_classes = [permissions.AllowAny]


class DeleteAccountView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def delete(self, request):
        user = request.user
        user.is_active = False
        user.save()
        return Response(status=status.HTTP_204_NO_CONTENT)


class UserInfoView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        user = request.user
        purchases = Purchase.objects.filter(user=user)
        purchase_list = [
            {"item_name": purchase.item_name, "purchase_date": purchase.purchase_date}
            for purchase in purchases
        ]
        user_info = {
            "email": user.email,
            "is_subscribed": user.is_subscribed,
            "purchases": purchase_list,
        }
        return Response(user_info, status=status.HTTP_200_OK)


class UserListView(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [permissions.AllowAny]


class CanPlayGameView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        user = request.user
        if user.is_subscribed:
            return Response({"can_play": True}, status=status.HTTP_200_OK)

        games_today = GamePlay.games_played_today(user)
        if games_today < 1:
            return Response({"can_play": True}, status=status.HTTP_200_OK)
        else:
            return Response({"can_play": False}, status=status.HTTP_403_FORBIDDEN)


class LogGamePlayView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        user = request.user
        if user.is_subscribed:
            GamePlay.objects.create(user=user)
            return Response({"success": True}, status=status.HTTP_201_CREATED)

        games_today = GamePlay.games_played_today(user)
        if games_today < 1:
            GamePlay.objects.create(user=user)
            return Response({"success": True}, status=status.HTTP_201_CREATED)
        else:
            return Response(
                {"success": False, "message": "Daily free game limit reached"},
                status=status.HTTP_403_FORBIDDEN,
            )
