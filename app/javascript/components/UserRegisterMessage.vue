<template>
  <div class="message" v-show="message">
    {{ message }}
  </div>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    computed: {
      ...mapState('messages', {
        message: state => state.userRegisterSuccessMessage
      })
    }
  }
</script>

<style scoped>
  .message {
    font-size:25px;
    border-radius: 16px 16px 16px 16px;
    color: green;
    background-color: #CCFFCC;
    width:400px;
    text-align: center;
  }
</style>
