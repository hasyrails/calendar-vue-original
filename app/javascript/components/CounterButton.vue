<template>
  <div style="display:flex;">
    <div>
      <button class="btn btn-primary" @click="countUp">{{ message }}: {{ count }}</button>
    </div>
    <div>
      <div v-if="count===1"><font-awesome-icon icon="coffee"  size="2x" /></div>
      <div v-else-if="count===2"><font-awesome-icon icon="bath"  size="2x" /></div>
      <div v-else-if="count===3"><font-awesome-icon icon="hamburger"  size="2x" /></div>
      <div v-else></div>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return {
      count: 0
    }
  },
  props:{
    // count: {
    //   type: Number
    // },
    message: {
      type: String
    },
  },
  methods: {
    countUp(){
      this.count ++
    }
    // countUp(){
    //   this.$emit('countUp')
    // }
  }
}
</script>

<style scoped>
  
</style>
