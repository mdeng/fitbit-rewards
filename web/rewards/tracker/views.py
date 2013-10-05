from django.shortcuts import *
from tracker.models import Goal

def home(request):
    return render_to_response("home.html",{},context_instance=RequestContext(request))
