from django.db import models

# Create your models here.

class Indicator(models.Model):
	#car = models.ForeignKey(Car, on_delete=models.CASCADE, null=True)
    title = models.CharField(max_length=50)
    symbol_name = models.CharField(max_length=50,null=True)
    time_frame = models.CharField(max_length=5,null=True)
    price = models.PositiveIntegerField(null=True)
    amount = models.FloatField(blank=True ,null=True)
    type = models.CharField(max_length=50,null=True)
    time_request = models.DateTimeField(blank=True, null=True)
    time_created = models.DateTimeField(auto_now_add=True, blank=True, null=True)    
    def __str__(self):
        return self.title