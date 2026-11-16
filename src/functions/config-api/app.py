"""GET /config — configuración global versionada, sin secretos (RF-AWS-24)."""
from common import auth, config


def handler(event, context):
    denied = auth.check(event)
    if denied:
        return denied
    cfg = config.get_config()
    return auth.response(200, {"config_version": config.config_version(cfg), "zones_version": cfg["ZONES_VERSION"],
                               "items": cfg})
