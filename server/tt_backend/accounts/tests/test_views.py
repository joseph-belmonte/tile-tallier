# accounts/tests/test_views.py

from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase
from accounts.models import User


class AccountTests(APITestCase):
    def test_user_registration(self):
        url = reverse("account-register")
        data = {
            "email": "test@example.com",
            "password": "testpassword",
            "password2": "testpassword",
            "is_subscribed": True,
        }
        response = self.client.post(url, data, format="json")

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(User.objects.count(), 1)
        self.assertEqual(User.objects.get().email, "test@example.com")

    def test_user_registration_duplicate_email(self):
        url = reverse("account-register")
        data = {
            "email": "test@example.com",
            "password": "testpassword",
            "password2": "testpassword",
            "is_subscribed": True,
        }
        self.client.post(url, data, format="json")
        response = self.client.post(url, data, format="json")
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn("error", response.data)

    def test_user_registration_default_is_subscribed(self):
        url = reverse("account-register")
        data = {
            "email": "test@example.com",
            "password": "testpassword",
            "password2": "testpassword",
            # 'is_subscribed' not provided, should default to False
        }
        response = self.client.post(url, data, format="json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        user = User.objects.get(email="test@example.com")
        self.assertFalse(user.is_subscribed)  # Should be False by default

    def test_user_registration_with_is_subscribed(self):
        url = reverse("account-register")
        data = {
            "email": "test2@example.com",
            "password": "testpassword",
            "password2": "testpassword",
            "is_subscribed": True,
        }
        response = self.client.post(url, data, format="json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        user = User.objects.get(email="test2@example.com")
        self.assertTrue(user.is_subscribed)  # Should be True as provided

    def test_user_registration_password_mismatch(self):
        url = reverse("account-register")
        data = {
            "email": "test3@example.com",
            "password": "testpassword",
            "password2": "differentpassword",
            "is_subscribed": True,
        }
        response = self.client.post(url, data, format="json")
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn("error", response.data)

    def test_user_login(self):
        user = User.objects.create_user(
            email="test@example.com", password="testpassword"
        )
        url = reverse("account-login")
        data = {"email": "test@example.com", "password": "testpassword"}
        response = self.client.post(url, data, format="json")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn("access", response.data)
        self.assertIn("refresh", response.data)
