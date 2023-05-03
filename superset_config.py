import os

from flask_talisman import Talisman

CONTENT_SECURITY_POLICY_WARNING = False
TALISMAN_ENABLED = True
TALISMAN_CONFIG = {
    'content_security_policy': {
        'default-src': '\'self\''
    }
}
FILTER_STATE_CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 300,
    'CACHE_KEY_PREFIX': 'superset_',
    'CACHE_REDIS_URL': 'redis://redis:6379/0',
}

EXPLORE_FORM_DATA_CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 300,
    'CACHE_KEY_PREFIX': 'superset_',
    'CACHE_REDIS_URL': 'redis://redis:6379/0',
}


SECRET_KEY = os.environ.get("SUPERSET_SECRET_KEY", "jiz2Ooz7E8CXZts2L/pJOaVf6+Me4J8D9BxPTAXVgoJRbX6jslBFDS/9")
