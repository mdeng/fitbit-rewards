from django.conf.urls import patterns, include, url
from django.conf import settings
from django.conf.urls.static import static

from tracker.api import *

from django.contrib import admin
admin.autodiscover()

goal_resource = GoalResource()

urlpatterns = patterns('',
    url(r'^$', 'tracker.views.home', name='home'),
    # url(r'^rewards/', include('rewards.foo.urls')),
    (r'^api/', include(goal_resource.urls)),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
) + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
