from django.contrib import admin
from django.contrib.auth.models import Group
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from accounts.models import User

admin.site.unregister(Group)


# Register your models here.
@admin.register(User)
class UserAdmin(BaseUserAdmin):

    search_fields = ["email", "username"]
    readonly_fields = ["id", "uuid", "created_at", "updated_at"]

    list_display = ["email", "is_active", "is_admin", "created_at"]

    list_filter = [
        "is_active",
        "is_admin",
        "created_at",
        "updated_at",
    ]

    filter_horizontal = []

    date_hierarchy = "created_at"
    ordering = ["-created_at"]

    add_fieldsets = (
        (
            ("Details"),
            {
                "fields": [
                    "email",
                ],
            },
        ),
        (
            "Account",
            {
                "fields": [
                    "is_active",
                    "is_admin",
                    "is_subscribed",
                ],
            },
        ),
    )

    fieldsets = (
        (
            ("Details"),
            {
                "fields": [
                    "id",
                    "uuid",
                    "email",
                    "username",
                ],
            },
        ),
        (
            "Account",
            {
                "fields": [
                    "is_active",
                    "is_admin",
                    "is_subscribed",
                    "password",
                ],
            },
        ),
    )

    class Media:
        pass
