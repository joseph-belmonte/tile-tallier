# accounts/views.py
from rest_framework import generics, permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.views import TokenObtainPairView
from .models import User, Purchase
from .serializers import UserSerializer


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
