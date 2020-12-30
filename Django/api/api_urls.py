from rest_framework import routers
from .api_views import IndicatorViewset


router = routers.SimpleRouter()
router.register('indicator', IndicatorViewset, basename='indicator')