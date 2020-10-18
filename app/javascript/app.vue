<template>
  <div id="app">
    <Header></Header>
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
    Header,
  },
  beforeCreate(){
    const existingSession = this.$cookies.get('session')

    if (existingSession && existingSession.length) { // A string at this point
      const session = JSON.parse(existingSession)
      this.$store.commit('auth/signIn', session.user)
      // this.$store.commit('auth', session.tokens)
    }
  },
}
</script>

<style scoped>
</style>
