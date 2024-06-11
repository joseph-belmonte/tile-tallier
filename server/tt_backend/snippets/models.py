""" This file defines models for the snippets app. """

# Create your models here.
from django.db import models
from pygments.lexers import get_all_lexers
from pygments.styles import get_all_styles

LEXERS = [item for item in get_all_lexers() if item[1]]
LANGUAGE_CHOICES = sorted([(item[1][0], item[0]) for item in LEXERS])
STYLE_CHOICES = sorted([(item, item) for item in get_all_styles()])


class Snippet(models.Model):
    """
    Defines the Snippet model
    """

    created = models.DateTimeField(auto_now_add=True)
    title = models.CharField(max_length=100, blank=True, default="")
    code = models.TextField()
    linenos = models.BooleanField(default=False)
    language = models.CharField(
        choices=LANGUAGE_CHOICES, default="python", max_length=100
    )
    style = models.CharField(choices=STYLE_CHOICES, default="friendly", max_length=100)

    class Meta:
        """
        Meta class to define the ordering of the snippets
        """

        ordering = ["created"]
