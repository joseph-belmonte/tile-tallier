# serializers.py
from rest_framework import serializers
from ..gemini.models import Game, Play


class PlaySerializer(serializers.ModelSerializer):
    class Meta:
        model = Play
        fields = "__all__"


class GameSerializer(serializers.ModelSerializer):
    plays = PlaySerializer(many=True, read_only=True)

    class Meta:
        model = Game
        fields = "__all__"
