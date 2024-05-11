from rest_framework.filters import BaseFilterBackend


class LevelFilter(BaseFilterBackend):
    """Фильтр по уровню одежды """

    def filter_queryset(self, request, queryset, view):
        if level := request.query_params.get('level'):
            queryset = queryset.filter(level=level)
        return queryset
