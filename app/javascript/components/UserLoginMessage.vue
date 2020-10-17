<template>
  <div class="overlay" v-if="message">
    <div class="content">
      <div class="modal-content message" >
        {{ message }}
      </div>
    </div>
  </div>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    computed: {
      ...mapState('messages', {
        message: state => state.userLoginSuccessMessage
      })
    }
  }
</script>

<style scoped>
  .message {
    font-size:32px;
    border-radius: 16px 16px 16px 16px;
    color: green;
    background-color: #CCFFCC;
    width:1000px;
    /* margin-left:50%; */
    text-align: center;
  }

  .content{
    z-index:201;
    width:600px;
    padding: 1em;
    /* background:#fff; */
    position: fixed;
    top: 20vh;
    left:30vw;
  }

  .overlay{
    /*　要素を重ねた時の順番　*/

    z-index:200;

    /*　画面全体を覆う設定　*/
    width:100vw;
    height:100vh;
    background-color: rgba(219,226,249,0.1);
    /* opacity: 0.5; */

    /*　画面の中央に要素を表示させる設定　*/
    display: flex;
    align-items: center;
    justify-content: center;
  }
</style>
