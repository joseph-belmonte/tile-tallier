# accounts/urls.py
from django.urls import path
from .views import revenuecat_webhook

urlpatterns = [
    path("webhook/", revenuecat_webhook, name="revenuecat-webhook"),
]
