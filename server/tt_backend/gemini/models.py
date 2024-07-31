# from django.db import models
# from ..accounts.models import User


# # Create your models here.
# class Game(models.Model):
#     player = models.ForeignKey(User, on_delete=models.CASCADE)
#     score = models.IntegerField()
#     date_played = models.DateTimeField(auto_now_add=True)
#     # other relevant fields...


# class Play(models.Model):
#     game = models.ForeignKey(Game, on_delete=models.CASCADE, related_name="plays")
#     move = models.CharField(max_length=255)
#     score = models.IntegerField()
#     timestamp = models.DateTimeField(auto_now_add=True)
#     # other relevant fields...
