# NOTE if git repo is not available, make sure env var is set upstream
GIT_REVISION = ENV['GIT_REVISION'] || `git rev-parse HEAD`
