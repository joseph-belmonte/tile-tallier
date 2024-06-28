from django.test import TestCase
from django.contrib.auth import get_user_model

User = get_user_model()


class AccountTests(TestCase):
    def test_user_creation(self):
        user = User.objects.create_user(
            email="test@example.com", password="testpassword"
        )
        self.assertEqual(user.email, "test@example.com")
        self.assertTrue(user.check_password("testpassword"))

    def test_user_duplicate_email(self):
        User.objects.create_user(email="test@example.com", password="testpassword")
        with self.assertRaises(Exception):  # Replace with specific exception
            User.objects.create_user(email="test@example.com", password="testpassword")

    def test_user_authentication(self):
        User.objects.create_user(email="test@example.com", password="testpassword")
        response = self.client.post(
            "/api/account/login/",
            {"email": "test@example.com", "password": "testpassword"},
        )
        self.assertEqual(response.status_code, 200)
