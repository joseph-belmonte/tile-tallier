# accounts/models.py
from django.db import models
from common.models import AbstractModel
from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.utils import timezone


class UserManager(BaseUserManager):
    def _create_user(self, email, password, **kwargs):
        if not email:
            raise ValueError("The Email field must be set")

        email = self.normalize_email(email)
        user = self.model(email=email, **kwargs)
        user.set_password(password)
        user.is_active = True  # Ensure the user account is active
        user.save(using=self._db)
        return user

    def create_user(self, email, password=None, **kwargs):
        kwargs["is_admin"] = False
        return self._create_user(email, password, **kwargs)

    def create_superuser(self, email, password=None, **kwargs):
        kwargs["is_admin"] = True
        return self._create_user(email, password, **kwargs)


class User(AbstractModel, AbstractUser):
    email = models.EmailField(unique=True, db_index=True, max_length=128)
    username = models.CharField(max_length=32, unique=True)
    password = models.CharField(max_length=128)
    is_subscribed = models.BooleanField(
        default=False, help_text="Designates whether subscribed to the premium plan"
    )
    is_active = models.BooleanField(
        default=True, help_text="Designates whether the user account is active"
    )

    is_admin = models.BooleanField(
        default=False, help_text="Designates whether the user is an admin"
    )

    objects = UserManager()

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []

    def __str__(self):
        return self.email

    @property
    def is_staff(self):
        return self.is_admin

    @property
    def is_superuser(self):
        return self.is_admin

    def has_perm(self, perm, obj=None):
        return self.is_admin

    def has_module_perms(self, app_label):
        return self.is_admin

    def get_all_permissions(self, obj=None):
        return []

    class Meta(AbstractModel.Meta):
        verbose_name = "User"
        verbose_name_plural = "Users"


class GamePlay(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    timestamp = models.DateTimeField(auto_now_add=True)

    @classmethod
    def games_played_today(cls, user):
        today = timezone.now().date()
        return cls.objects.filter(user=user, timestamp__date=today).count()


class Purchase(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    item_name = models.CharField(max_length=255)
    purchase_date = models.DateTimeField(auto_now_add=True)
