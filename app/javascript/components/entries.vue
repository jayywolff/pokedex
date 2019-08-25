<template>
  <div id="app">
    <div class="row my-4 mx-n1">
      <div class="col-md-6 px-md-4">
        <b-form-group id="name-filter-label" label="Search By Name:" label-for="name-filter">
          <b-form-input id="name-filter" v-model="nameFilter" type="search" placeholder="Search By Name:">
          </b-form-input>
        </b-form-group>
      </div>
      <div class="col-md-6 px-md-4">
        <b-form-group id="type-filter-label" label="Search By Type:" label-for="type-filter">
          <b-form-select id="type-filter" v-model="typeFilter" :options="types" @change="filterByType">
            <template slot="first"><option value="">All</option></template>
          </b-form-select>
        </b-form-group>
      </div>
    </div>

    <b-table striped hover bordered dark small
      :fields="fields"
      :items="items"
      :sort-by="sortBy"
      :filter="nameFilter"
      :filter-included-fields="filterBy"
    >
      <template slot="[id]" slot-scope="data">
        <a class="d-block" :href="data.item.link" tabindex="0">{{ data.value }}</a>
      </template>
      <template slot="[sprite]" slot-scope="data">
        <img class="img-fluid" :src="data.value" :alt="data.item.name.toLowerCase() + '-sprite'"/>
      </template>
    </b-table>
  </div>
</template>

<script>
export default {
  props: ['pokemon', 'types'],
  data() {
    return {
      items: this.pokemon,
      fields: [
        { key: 'id', sortable: true },
        { key: 'name', sortable: true },
        { key: 'type', sortable: true },
        { key: 'sprite', sortable: false }
      ],
      nameFilter: '',
      typeFilter: '',
      filterBy: ['name'],
      sortBy: 'id'
    }
  },
  methods: {
    filterByType() {
      if (this.typeFilter == '') {
        this.items = this.pokemon
      } else {
        this.items = this.pokemon.filter(pokemon => pokemon.type == this.typeFilter)
      }
    }
  }
}
</script>
