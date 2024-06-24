from django.urls import include, path

urlpatterns = [ 
    path("game/", include("api.game.urls")),
]
