# settings_test.py
import os
from datetime import timedelta

# Basic configurations needed for testing

# Secret key for testing (can be anything for CI)
SECRET_KEY = "test_secret_key"

# Debug setting for tests (typically False to match production)
DEBUG = False

# Allowed hosts for tests (only localhost needed)
ALLOWED_HOSTS = ["localhost"]

# Test-specific database configuration
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "test_db",
        "USER": "postgres",
        "PASSWORD": "postgres",
        "HOST": "localhost",
        "PORT": 5432,
    }
}

# Set JWT settings specifically for tests
SIMPLE_JWT = {
    "ACCESS_TOKEN_LIFETIME": timedelta(minutes=5),
    "REFRESH_TOKEN_LIFETIME": timedelta(days=1),
    "BLACKLIST_AFTER_ROTATION": True,
    "AUTH_HEADER_TYPES": ("Bearer",),
    "USER_ID_FIELD": "uuid",
}

# Authentication and other secrets for testing purposes
GOOGLE_API_KEY = "test_google_api_key"
AUTH_TOKEN_SECRET = "test_auth_token_secret"
AUTH_JWT_SIGNING_KEY = "test_signing_key"

# Pagination and API limits for tests
API_DEFAULT_PAGE_SIZE = 10
API_MAX_PAGE_SIZE = 100

# Static and media files settings
STATIC_ROOT = os.path.join("staticfiles")
MEDIA_ROOT = os.path.join("mediafiles")

# Disable throttling in the test environment (optional)
REST_FRAMEWORK = {
    "DEFAULT_AUTHENTICATION_CLASSES": [
        "rest_framework_simplejwt.authentication.JWTAuthentication",
    ],
    "DEFAULT_THROTTLE_CLASSES": [],
    "DEFAULT_PAGINATION_CLASS": "rest_framework.pagination.PageNumberPagination",
    "PAGE_SIZE": 10,
}
