from content.models import Game
from django_filters import FilterSet, NumberFilter


class GameFilter(FilterSet):
    owner = NumberFilter(field_name="owner")

    class Meta:
        model = Game
        fields = ["owner"]
