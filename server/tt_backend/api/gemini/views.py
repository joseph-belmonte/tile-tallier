# views.py
import json
import environ
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
import google.generativeai as genai

from ..permissions import IsAuthenticated, IsSubscribed

from .constants import SYSTEM_INSTRUCTION, SAFETY_SETTINGS, GENERATION_CONFIG

# Load environment variables
env = environ.Env()
GOOGLE_API_KEY = env("GOOGLE_API_KEY")

# Configure the Gemini API
genai.configure(api_key=GOOGLE_API_KEY)

# Define the generative model
model = genai.GenerativeModel(
    "gemini-1.5-flash",
    generation_config=GENERATION_CONFIG,
    safety_settings=SAFETY_SETTINGS,
    system_instruction=SYSTEM_INSTRUCTION,
)


def request_advice(player_id, game_data):
    """Send a prompt to the Gemini model and return its response."""
    prompt = (
        f"Hello, Gemini! I am a Scrabble player and I would like some advice on how to improve my game. "
        f"Note my player id is {player_id}. Here is my recent game data: {json.dumps(game_data)}"
    )
    try:
        return model.generate_content(prompt)
    except Exception:
        return None


class AdviceView(APIView):
    """View for generating Scrabble advice using the Gemini API."""

    permission_classes = [IsAuthenticated, IsSubscribed]

    def post(self, request):
        # Validate input
        player_id = request.data.get("player_id")
        game_data = request.data.get("game_data")

        if not player_id or not game_data:
            return Response(
                {
                    "status": "error",
                    "message": "Invalid input data. Both 'player_id' and 'game_data' are required.",
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        # Call the Gemini API
        response = request_advice(
            player_id=player_id,
            game_data=game_data,
        )

        if not response:
            return Response(
                {
                    "status": "error",
                    "message": "Failed to generate advice. Please try again later.",
                },
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

        # Parse the Gemini API response
        try:
            advice = json.loads(response.candidates[0].content.parts[0].text)["advice"]
        except (KeyError, IndexError, json.JSONDecodeError) as e:
            return Response(
                {
                    "status": "error",
                    "message": f"Error parsing advice response: {e}",
                },
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

        # Return the advice in the response
        return Response(
            {
                "status": "success",
                "advice": advice,
                "game_data": game_data,
                "player_id": player_id,
            },
            status=status.HTTP_200_OK,
        )
