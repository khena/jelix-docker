#!/bin/bash

bash /config_timezone.bash
bash /config_phpini.bash
bash /config_jelix.bash

exec "$@"
