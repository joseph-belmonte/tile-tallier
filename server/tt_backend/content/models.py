from datetime import timezone
from django.db import models
from common.models import AbstractModel
from accounts.models import User


# Create your models here.


class Game(AbstractModel):
    """Game model for storing game data for premium users"""

    # Each game has an owner
    owner = models.ForeignKey(
        User,
        verbose_name="Owner",
        related_name="games",
        on_delete=models.CASCADE,
    )

    # TODO: add game fields here, should match the game data structure from client


class GamePlay(AbstractModel, models.Model):
    """Gameplay model for logging game instances"""

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    timestamp = models.DateTimeField(auto_now_add=True)

    @classmethod
    def games_played_today(cls, user):
        today = timezone.now().date()
        return cls.objects.filter(user=user, timestamp__date=today).count()
