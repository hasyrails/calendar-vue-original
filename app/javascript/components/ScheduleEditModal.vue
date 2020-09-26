<template>
  <div class="overlay" v-on:click="clickEvent">
    <div class="content">
      <div class="modal-content" >
      <div class="modal-header" :style="'background-color:'+schedule.color+';'">
        <div>
          <div style="font-size:25px;">
            <!-- {{ devidedSchedule.yyyymmdd }} -->
          </div>
          <div class="schedule-title">
            <div class="schedule-tag" style="margin-top:10px;"><Tag :size="36"></Tag></div>
            <div class="schedule-title" style="font-size:36px; margin-left:10px;">{{ schedule.title }}[編集]</div>
          </div>
        </div>
        <div @click="closeScheduleSettingModal">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true" style="font-size:36px;">&times;</span>
          </button>
        </div>
      </div>
    <div class="modal-body" style="background-color:white;">
      <div class="form-group">
        <label for="title">タイトル</label>
        <input
        v-model="schedule.title"
        type="text"
        class="form-control"
        >
      </div>
      <!-- 色選択フォーム -->
    </div>
    <div class="modal-footer" style="background-color:white;">
        <div class="btn btn-primary"
        @click="updateSchedule"
        >
          保存する
        </div>
        <div class="btn btn-danger"
        @click="closeScheduleEditModal"
        >編集をやめる</div>
      </div>
    </div>
    </div>
  </div>
</template>

<script>
import Tag from 'vue-material-design-icons/Tag.vue';

export default {
  props: {
    schedule:{
      type: Object,
      default: () => {},
    }
  },
  components:{
    Tag
  },
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
    updateSchedule(){
      this.$emit('clickScheduleUpdateButton', this.schedule)
    },
    closeScheduleEditModal(){
      this.$emit('clickScheduleEditModalCloseButton')
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

.schedule-title{
  display: flex;
}
.modal-body{
  margin-left: 30%;
}

.schedule-item{
  display: flex;
  margin-top: 10px;
  margin-bottom: 10px;
}
.schedule-item-name{
  font-size:36px;
  text-decoration: underline;
  width:200px;
  text-align: center;
}
.schedule-item-content{
  margin-left: 30px;
  font-size:24px;
}

.schedule-date{
  display: flex;
}
.schedule-start-date{
  text-align: center;
  margin-left: 10px;
  margin-right: 20px;
}
.schedule-end-date{
  text-align: center;
  margin-left: 20px;
  margin-right: 10px;
}
.schedule-color{
  margin-left: 130px;
}
</style>
