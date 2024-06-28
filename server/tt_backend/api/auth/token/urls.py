from django.urls import path
from .views import TokenCreateView, TokenRefreshView

urlpatterns = [
    path("", TokenCreateView.as_view(), name="token_create"),
    path("refresh/", TokenRefreshView.as_view(), name="token_refresh"),
]
