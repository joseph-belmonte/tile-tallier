from django.urls import path
from api.account.views import *

urlpatterns = [
    path("register/", AccountRegisterView.as_view(), name="register"),
    path("login/", AccountLoginView.as_view(), name="login"),
    path("user_info/", AccountInfoView.as_view(), name="user_info"),
    path("delete_account/", AccountDeleteView.as_view(), name="delete_account"),
]
