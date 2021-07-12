import functools

def replaceNoneKwargsModel(func):

    @functools.wraps(func)
    def wrapper(self, *args, **kwargs):
        if 'model' not in kwargs:
            actual = None
        else:
            actual = kwargs['model']
        if actual is None:
            with self.getViewModel().transaction() as (model):
                kwargs['model'] = model
                return func(self, *args, **kwargs)
        else:
            return func(self, *args, **kwargs)
        return

    return wrapper