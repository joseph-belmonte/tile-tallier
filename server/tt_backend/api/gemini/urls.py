from django.urls import path
from api.gemini.views import AdviceView

urlpatterns = [
    path("advice/", AdviceView.as_view(), name="advice"),
]
