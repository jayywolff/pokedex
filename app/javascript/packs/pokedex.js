import Vue from 'vue/dist/vue.esm'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import { DropdownPlugin, TablePlugin } from 'bootstrap-vue'
Vue.use(DropdownPlugin)
Vue.use(TablePlugin)

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

