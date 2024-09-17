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
    path('', include(api.urls), name='index')
]