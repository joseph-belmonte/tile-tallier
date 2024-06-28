from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase
from django.contrib.auth import get_user_model
from content.models import GamePlay

User = get_user_model()


class GameTests(APITestCase):

    def setUp(self):
        self.user = User.objects.create_user(
            email="testuser@example.com",
            password="password123",
            is_subscribed=False,
        )
        self.subscribed_user = User.objects.create_user(
            email="subscribeduser@example.com",
            password="password123",
            is_subscribed=True,
        )

    def test_can_play_game_subscribed_user(self):
        self.client.force_authenticate(user=self.subscribed_user)
        url = reverse("can_play")
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, {"can_play": True})

    def test_can_play_game_free_user_no_games_played(self):
        self.client.force_authenticate(user=self.user)
        url = reverse("can_play")
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, {"can_play": True})

    def test_can_play_game_free_user_games_played(self):
        self.client.force_authenticate(user=self.user)
        GamePlay.objects.create(user=self.user)
        url = reverse("can_play")
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
        self.assertEqual(response.data, {"can_play": False})

    def test_log_game_play_subscribed_user(self):
        self.client.force_authenticate(user=self.subscribed_user)
        url = reverse("log_play")
        response = self.client.post(url)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data, {"success": True})

    def test_log_game_play_free_user_no_games_played(self):
        self.client.force_authenticate(user=self.user)
        url = reverse("log_play")
        response = self.client.post(url)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data, {"success": True})

    def test_log_game_play_free_user_games_played(self):
        self.client.force_authenticate(user=self.user)
        GamePlay.objects.create(user=self.user)
        url = reverse("log_play")
        response = self.client.post(url)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
        self.assertEqual(
            response.data,
            {"success": False, "message": "Daily free game limit reached"},
        )
