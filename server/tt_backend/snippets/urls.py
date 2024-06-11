""" This file is used to define the URL patterns for the snippets app. """

from django.urls import path
from snippets import views

urlpatterns = [
    path("snippets/", views.snippet_list),
    path("snippets/<int:pk>/", views.snippet_detail),
]
