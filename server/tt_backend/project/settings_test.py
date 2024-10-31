# settings_test.py
from .settings import *  # Import all the base settings

# Override settings for testing

# Database configuration for tests
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "test_db",  # Name of the test database
        "USER": "postgres",  # Default user for Postgres in GitHub Actions
        "PASSWORD": "postgres",  # Default password for Postgres in GitHub Actions
        "HOST": "localhost",  # Database host in the CI environment
        "PORT": 5432,  # Standard PostgreSQL port
    }
}

# Use a simple secret key for testing (this can be anything)
SECRET_KEY = "test_secret_key"

# Set debug to False for test environments to avoid unintentional debug output
DEBUG = False

# Allowed hosts for testing, typically just localhost
ALLOWED_HOSTS = ["localhost"]

# Set up default authentication and token settings for testing
ACCESS_TOKEN_LIFETIME = "5m"  # Short token lifetime for tests
REFRESH_TOKEN_LIFETIME = "1d"

# Simple JWT settings for token handling in tests
SIMPLE_JWT = {
    "ACCESS_TOKEN_LIFETIME": timedelta(minutes=5),  # Short lifetime for testing
    "REFRESH_TOKEN_LIFETIME": timedelta(days=1),  # Daily refresh token lifetime
    "BLACKLIST_AFTER_ROTATION": True,
    "AUTH_HEADER_TYPES": ("Bearer",),
    "USER_ID_FIELD": "uuid",
}

# Use a mock API key for testing
GOOGLE_API_KEY = "test_google_api_key"

# Mock authentication token secret for tests
AUTH_TOKEN_SECRET = "test_auth_token_secret"

# Define pagination and API limits for testing
API_DEFAULT_PAGE_SIZE = 10
API_MAX_PAGE_SIZE = 100

# Mock JWT signing key for tests
AUTH_JWT_SIGNING_KEY = "test_signing_key"

# Specify static and media root (if used in tests)
STATIC_ROOT = BASE_DIR / "staticfiles"
MEDIA_ROOT = BASE_DIR / "mediafiles"

# Disable throttling for tests (optional, if throttling interferes with test results)
REST_FRAMEWORK["DEFAULT_THROTTLE_CLASSES"] = []
