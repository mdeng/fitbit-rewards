from tastypie.resources import ModelResource
from tracker.models import *
from tastypie import fields

class UserProfileResource(ModelResource):
    class Meta:
        queryset = UserProfile.objects.all()
        resource_name = 'user_profile'

class PenaltyResource(ModelResource):
    class Meta:
        queryset = Penalty.objects.all()
        resource_name = 'penalty'

class GoalResource(ModelResource):
    penalty = fields.ToOneField(PenaltyResource,"penalty")
    def dehydrate(self,bundle):
        bundle.data['user_profile'] = bundle.obj.userprofile_set.all()[0]
        return bundle
    class Meta:
        queryset = Goal.objects.all()
        resource_name = 'goal'
