#!/usr/bin/python3


class ParameterInjector:
    def __init__(self, param_str: str):
        self.__param_str = param_str

    def __call__(self, func):
        @wraps(func)
        def inner(*args, **kwargs):
            with self as param_str:
                return_value = func(param_str, *args, **kwargs)
                return return_value

        return inner
