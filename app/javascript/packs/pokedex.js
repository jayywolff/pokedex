import Vue from 'vue/dist/vue.esm'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import { TablePlugin, FormGroupPlugin, FormInputPlugin, FormSelectPlugin } from 'bootstrap-vue'
Vue.use(TablePlugin)
Vue.use(FormGroupPlugin)
Vue.use(FormInputPlugin)
Vue.use(FormSelectPlugin)

import Entries from '../components/entries.vue'

document.addEventListener('DOMContentLoaded', () => {
  const element = document.getElementById('data')
  const pokemon = JSON.parse(element.dataset.pokemon) || []
  const types   = JSON.parse(element.dataset.types) || []

  const app = new Vue({
    el: '#pokedex',
    data: {
      pokemon: pokemon,
      types: types
    },
    components: { Entries }
  })
})

