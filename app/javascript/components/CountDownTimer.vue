<template>
  <div class="countdown" v-if="countDown>0">残り{{ countDown }}秒!!!</div>
</template>

<script>
export default {
  data() {
      return {
          countDown: 24*60*60 - new Date().getHours()*60*60 - new Date().getMinutes()*60 - new Date().getSeconds()
      }
  },
  methods: {
    countDownTimer() {
          if(this.countDown > 0) {
              setTimeout(() => {
                  this.countDown -= 1
                  this.countDownTimer()
              }, 1000)
          }
    }
  },
  created() {
    this.countDownTimer()
  }
}
</script>

<style scoped>
  .countdown{
    color: red;
    font-size:10px;
  }
</style>
