<template>
  <div id="app">
    <Header v-if="!showDone"></Header>
    <HeaderOfDone v-if="showDone"></HeaderOfDone>
    <router-view >
    </router-view>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Header from '../javascript/components/Header'
import HeaderOfDone from '../javascript/components/HeaderOfDone'

export default {
  data: function () {
    return {
      // showDone: false
    }
  },
  components: {
    Header,
    HeaderOfDone,
  },
  methods:{
    // showDoneSchedules(){
    //   this.showDone = true
    // }
  },
  computed:{
    ...mapGetters([
      'showDone'
    ]),
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
