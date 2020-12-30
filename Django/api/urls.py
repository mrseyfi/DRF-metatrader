# -*- encoding: utf-8 -*-
"""
License: MIT
Copyright (c) 2020 - present AppSeed.us
"""
from django.contrib import admin
from django.shortcuts import render
from django.urls import path, re_path, include
from rest_framework.authtoken.views import obtain_auth_token
from .api_urls import router
from . import views

from django.views.decorators.cache import cache_page



urlpatterns = [
    # path('getprice/', views.getprice, name='dollar'), 
    path('api-token-auth/', obtain_auth_token),
    path('api/', include(router.urls)),
    path('api-auth/', include('rest_framework.urls')),
]
