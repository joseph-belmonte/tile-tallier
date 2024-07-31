from django.urls import include, path

urlpatterns = [
    path("game/", include("api.game.urls")),
    path("auth/", include("api.auth.urls")),
    path("account/", include("api.account.urls")),
    path("gemini/", include("api.gemini.urls")),
]
