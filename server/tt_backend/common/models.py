from django.db import models
from uuid import uuid


# Create your models here.
class AbstractModel(models.Model):

    uuid = models.UUIDField(
        ("UUID"),
        default=uuid.uuid4,
        unique=True,
        editable=False,
        db_index=True,
    )

    created_at = models.DateTimeField(("Created At"), auto_now_add=True)
    updated_at = models.DateTimeField(("Updated At"), auto_now=True)

    class Meta:
        abstract = True
        ordering = ["-created_at"]
