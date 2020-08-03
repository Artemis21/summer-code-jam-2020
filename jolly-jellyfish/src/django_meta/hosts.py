from django_hosts import patterns, host

def viewing(request, dynamic_part):
	request.dynamic_part = dynamic_part

host_patterns = patterns('',
    host(r'halfway', 'django_meta.urls', name='main'),
    host(r'(?P<dynamic_part>\w+)\.halfway', 'customdomains.urls', name='others', callback=viewing),
)