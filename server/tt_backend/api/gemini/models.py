# from django.db import models

# from ...common.models import AbstractModel

# from ...accounts.models import User


# class Game(AbstractModel):
#     player = models.ForeignKey(User, on_delete=models.CASCADE)
#     score = models.IntegerField()
#     date_played = models.DateTimeField(auto_now_add=True)
#     # other relevant fields...


# class Play(AbstractModel):
#     game = models.ForeignKey(Game, on_delete=models.CASCADE, related_name="plays")
#     move = models.CharField(max_length=255)
#     score = models.IntegerField()
#     timestamp = models.DateTimeField(auto_now_add=True)
#     # other relevant fields...


# class ChatBot(AbstractModel):
#     user = models.ForeignKey(
#         User, on_delete=models.CASCADE, related_name="GeminiUser", null=True
#     )
#     text_input = models.CharField(max_length=500)
#     gemini_output = models.TextField(null=True, blank=True)
#     date = models.DateTimeField(auto_now_add=True, blank=True, null=True)

#     def __str__(self):
#         return self.text_input
