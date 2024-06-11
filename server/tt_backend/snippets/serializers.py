"""
Serializers convert data to/from the JSON and database representations. 
"""

from rest_framework import serializers
from snippets.models import Snippet
from django.contrib.auth.models import User


class SnippetSerializer(serializers.Serializer):
    """
    A serializer class for the Snippet model
    """

    owner = serializers.ReadOnlyField(source="owner.username")

    class Meta:
        model = Snippet
        fields = ["id", "title", "code", "linenos", "language", "style", "owner"]


class UserSerializer(serializers.ModelSerializer):
    snippets = serializers.PrimaryKeyRelatedField(
        many=True, queryset=Snippet.objects.all()
    )

    class Meta:
        model = User
        fields = [
            "id",
            "username",
            "snippets",
        ]  # manually added snippets field, because it is not on the default User model
