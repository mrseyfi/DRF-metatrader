from rest_framework import viewsets,status
from .models import Indicator
from django.shortcuts import get_object_or_404
from rest_framework.response import Response
from .serializers import IndicatorSerializer 



class IndicatorViewset(viewsets.ModelViewSet):
    queryset = Indicator.objects.all()
    serializer_class = IndicatorSerializer

    def create(self, request, *args, **kwargs):
            is_many = isinstance(request.data, list)
            if not is_many:
                return super(IndicatorViewset, self).create(request, *args, **kwargs)
            else:
                serializer = self.get_serializer(data=request.data, many=True)
                serializer.is_valid(raise_exception=True)
                self.perform_create(serializer)
                headers = self.get_success_headers(serializer.data)
                return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
          