const { environment } = require('@rails/webpacker')
const customConfig = require('./custom')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.config.merge(customConfig)
module.exports = environment
