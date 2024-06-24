from rest_framework import generics, permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.views import TokenObtainPairView
from content.models import GamePlay


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
