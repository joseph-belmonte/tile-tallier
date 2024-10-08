# accounts/views.py
from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.shortcuts import get_object_or_404
from .models import User


@api_view(["POST"])
def revenuecat_webhook(request):
    """
    How this works:

    1. This webhook view listens for POST requests from RevenueCat.
    2. Based on the event (whether it's a purchase or cancellation), the is_subscribed status is updated for the corresponding user.
    3. The user_id field in the webhook payload should match the ID of the user in your database.
    """
    event_type = request.data.get("event")  # Example: PURCHASE, CANCELLATION
    user_id = request.data.get("user_id")  # The user associated with the event

    if not user_id:
        return Response(
            {"error": "User ID not provided"}, status=status.HTTP_400_BAD_REQUEST
        )

    # Get the user by ID or return a 404
    user = get_object_or_404(User, id=user_id)

    if event_type == "PURCHASE":
        user.is_subscribed = True
        user.save()
        return Response(
            {"message": "Subscription activated"}, status=status.HTTP_200_OK
        )

    elif event_type == "CANCELLATION":
        user.is_subscribed = False
        user.save()
        return Response({"message": "Subscription canceled"}, status=status.HTTP_200_OK)

    return Response({"error": "Invalid event type"}, status=status.HTTP_400_BAD_REQUEST)
