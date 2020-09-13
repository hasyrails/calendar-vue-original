<template>
  <div id="app">
    <Header></Header>
    <router-link to="/">
    </router-link>
    <router-view></router-view>
  </div>
</template>

<script>
import Header from '../javascript/components/Header'

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  components: {
    Header
  }
}
</script>

<style scoped>

</style>
