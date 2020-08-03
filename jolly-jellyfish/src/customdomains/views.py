from django.http import HttpResponse


def index(request):
    return HttpResponse(f"You're looking at <code>{request.dynamic_part}</code>'s future page!")
