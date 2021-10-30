try:
    from time import monotonic as maybe_monotonic_time
except ImportError:
    from time import time as maybe_monotonic_time