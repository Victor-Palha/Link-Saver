#!/usr/bin/env bash

mix deps.get --only prod
MIX_ENV=prod mix compile
MIX_ENV=prod mix assets.deploy
MIX_ENV=prod mix release
MIX_ENV=prod mix ecto.migrate
_build/prod/rel/demo/bin/demo start