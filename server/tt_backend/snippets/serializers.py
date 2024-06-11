"""
Serializers convert data to/from the JSON and database representations.
"""

from rest_framework import serializers
from snippets.models import Snippet


class SnippetSerializer(serializers.Serializer):
    """
    A serializer class for the Snippet model
    """

    class Meta:
        model = Snippet
        fields = ["id", "title", "code", "linenos", "language", "style"]
