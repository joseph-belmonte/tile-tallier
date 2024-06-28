from django.contrib import admin
from content.models import Game, GamePlay


# Register your models here.
@admin.register(Game)
class PostAdmin(admin.ModelAdmin):
    list_display = ("owner", "created_at", "updated_at")
    list_filter = ("created_at", "updated_at")
    search_fields = ("owner",)
    date_hierarchy = "created_at"
    ordering = ("created_at",)
    autocomplete_fields = ("owner",)
    readonly_fields = ("created_at", "updated_at")


@admin.register(GamePlay)
class GamePlayAdmin(admin.ModelAdmin):
    list_display = ("user", "timestamp")
    list_filter = ("timestamp",)
    search_fields = ("user",)
    date_hierarchy = "timestamp"
    ordering = ("timestamp",)
    autocomplete_fields = ("user",)
    readonly_fields = ("timestamp",)
