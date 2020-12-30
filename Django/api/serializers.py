from rest_framework import serializers
from .models import Indicator

class IndicatorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Indicator
        fields = ('title', 'symbol_name', 'time_frame', 'price','amount', 'type', 'time_request', 'time_created')
        extra_kwargs = {
            #'email':{'write_only':True}
        }
