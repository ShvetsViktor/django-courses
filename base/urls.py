"""base URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from api.models import CategoryResource, CourseResource
from tastypie.api import Api

api = Api(api_name='v1')
course_resource = CourseResource()
category_resource = CategoryResource()
api.register(course_resource)
api.register(category_resource)

# api/v1/courses/       GET, POST
# api/v1/courses/1/     GET, DELETE
# api/v1/categories/    GET
# api/v1/categories/1/  GET

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('shop.urls')),
    path('api/', include('api.urls'))
]
