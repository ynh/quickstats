config = {api: {}}

production = no

config.api.root = "http://192.168.1.58/quickstats_backend/"
config.api.versionRoot = config.api.root+'index.php'
config.api.base = config.api.root  

module.exports = config
