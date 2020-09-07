<template>
  <div id="app">
    <router-link to="/">
    </router-link>
    <router-link to="/register">
    </router-link>
    <router-view></router-view>
  </div>
</template>

<script>
import Top from '../javascript/pages/Top'
import Register from '../javascript/pages/Register'

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  components: {
    Top,
    Register
  }
}
</script>

<style scoped>

</style>
