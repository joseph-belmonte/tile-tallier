from rest_framework import serializers
from content.models import GamePlay


class GamePlaySerializer(serializers.ModelSerializer):
    class Meta:
        model = GamePlay
        fields = ["id", "uuid", "user", "timestamp"]

        read_only_fields = ["id", "uuid", "user", "owner", "timestamp"]
