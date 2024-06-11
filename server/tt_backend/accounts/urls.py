from django.urls import path
from .views import *
from rest_framework_simplejwt.views import TokenRefreshView

urlpatterns = [
    path("register/", RegisterView.as_view(), name="register"),
    path("login/", LoginView.as_view(), name="login"),
    path("token/refresh/", TokenRefreshView.as_view(), name="token_refresh"),
    path("can_play/", CanPlayGameView.as_view(), name="can_play"),
    path("log_play/", LogGamePlayView.as_view(), name="log_play"),
    path("user_info/", UserInfoView.as_view(), name="user_info"),
    path("delete_account/", DeleteAccountView.as_view(), name="delete_account"),
]
