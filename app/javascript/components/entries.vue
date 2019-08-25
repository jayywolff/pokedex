<template>
  <div id="app">
    <b-table striped hover dark :items="pokemon"></b-table>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  props: ['pokemon', 'types']
}
</script>
