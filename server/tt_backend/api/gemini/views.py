# views.py
import json
import environ
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
import google.generativeai as genai

from ...api.permissions import IsAuthenticated
from ...accounts.models import User
from .constants import SYSTEM_INSTRUCTION, SAFETY_SETTINGS, GENERATION_CONFIG

# Load environment variables
env = environ.Env()
GOOGLE_API_KEY = env("GOOGLE_API_KEY")

# Configure the Gemini API
genai.configure(api_key=GOOGLE_API_KEY)

# Using `response_mime_type` requires one of the Gemini 1.5 Pro or 1.5 Flash models
model = genai.GenerativeModel(
    "gemini-1.5-flash",
    # Set the `response_mime_type` to output JSON
    generation_config=GENERATION_CONFIG,
    safety_settings=SAFETY_SETTINGS,
    system_instruction=SYSTEM_INSTRUCTION,
)


def request_advice(player_id, game_data):
    prompt = f"Hello, Gemini! I am a Scrabble player and I would like some advice on how to improve my game. Note my player id is {player_id}. Here is my recent game data: {json.dumps(game_data)}"
    try:
        response = model.generate_content(prompt)

        return response
    except Exception as e:

        return None


class AdviceView(APIView):
    authentication_classes = [IsAuthenticated]

    def post(self, request):
        # Set some sort of throttle to prevent abuse
        # Start with 1 request per week.

        user = request.user

        if not user.is_subscribed:
            return Response(
                {
                    "status": "error",
                    "message": "This feature is only available for premium users.",
                },
                status=status.HTTP_403_FORBIDDEN,  # Forbidden response for non-premium users
            )

        # Get the player's ID and game data
        player_id = request.data.get("player_id")
        game_data = request.data.get("game_data")

        # Validate inputs
        if not player_id or not game_data:
            return Response(
                {
                    "status": "error",
                    "message": "Invalid input data",
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        # Send data to Gemini model
        response = request_advice(
            player_id=player_id,
            game_data=game_data,
        )

        if not response:
            return Response(
                {
                    "status": "error",
                    "message": "Failed to generate advice",
                },
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

        # Extract the advice from the response
        try:
            advice = json.loads(response.candidates[0].content.parts[0].text)["advice"]
        except Exception as e:
            return Response(
                {
                    "status": "error",
                    "message": f"Error parsing advice: {e}",
                },
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

        # Return feedback to client
        return Response(
            {
                "status": "success",
                "advice": advice,
                "game_data": game_data,
                "player_id": player_id,
            },
            status=status.HTTP_200_OK,
        )
