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
  },
  beforeCreate(){
    const existingSession = this.$cookie.get('session')

    if (existingSession && existingSession.length) { // A string at this point
      const session = JSON.parse(existingSession)
      this.$store.commit('user', session.user)
      this.$store.commit('auth', session.tokens)
    }
  },
}
</script>

<style scoped>
</style>
