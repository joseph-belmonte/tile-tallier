from django.urls import path
from api.game.views import CanPlayGameView, LogGamePlayView

urlpatterns = [
    path("can_play/", CanPlayGameView.as_view(), name="can_play"),
    path("log_play/", LogGamePlayView.as_view(), name="log_play"),
]
