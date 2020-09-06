<template>
  <div>
    <button @click="countUp">{{ message }}: {{ count }}</button>
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
