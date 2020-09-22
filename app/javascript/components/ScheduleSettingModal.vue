<template>
  <div class="overlay" v-on:click="clickEvent">
    <div class="content">
      <div class="btn btn-danger close-button" @click="closeScheduleSettingModal">✖︎</div>
      <!-- <div>{{ devidedSchedule.title }}</div> -->
    </div>
  </div>
</template>

<script>
export default {
  data: {
    // openModal: false
  },
  // props: {
  //   devidedSchedule:{
  //     type: Object,
  //   }
  // },
  methods:{
    openModal: function(){
      this.showContent = true
    },    
    closeModal: function(){
      this.showContent = false
    },
    closeScheduleSettingModal(){
      this.$emit('clickCloseButton')
    },
  }
}

</script>

<style scoped>
.content{
  z-index:201;
  width:80%;
  padding: 1em;
  background:#fff;
}

.overlay{
  /*　要素を重ねた時の順番　*/

  z-index:200;

  /*　画面全体を覆う設定　*/
  position: fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background-color: rgba(219,226,249,0.1);
  /* opacity: 0.5; */

  /*　画面の中央に要素を表示させる設定　*/
  display: flex;
  align-items: center;
  justify-content: center;

}

.close-button{
  cursor: pointer;
}
</style>
