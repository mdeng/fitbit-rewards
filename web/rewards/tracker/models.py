from django.db import models
from django.contrib.auth.models import User
from django.contrib import admin
import datetime

class Penalty(models.Model):
    type = models.CharField(max_length=100,default="facebook")
    message = models.TextField(default="I failed....")
admin.site.register(Penalty)

class Goal(models.Model):
    miles = models.IntegerField(default = 0)
    penalty = models.ForeignKey(Penalty,null=True)
    deadline = models.DateTimeField(default = datetime.datetime.now())
admin.site.register(Goal)

class UserProfile(models.Model):
    user = models.ForeignKey(User, unique=True)
    goals = models.ManyToManyField(Goal,null=True)
    def __unicode__(self):
        return str(self.user)
admin.site.register(UserProfile)
