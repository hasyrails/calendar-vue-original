<template>
  <div class="overlay">
    <div class="content">
      <div class="modal-content" >
        <div class="modal-header">
          <div>
            <div style="font-size:25px;">
              {{ list.title }}
            </div>
            <div class="schedule-title">
              <div class="schedule-tag" style="margin-top:10px;"><Tag :size="36"></Tag></div>
              <div class="schedule-title" style="font-size:36px; margin-left:10px;width:900px;">
              {{ card.body }}
                <div 
                class="card-updated-at"
                >
                  <div class="schedule-created-at-date" style="width:300px;">
                    <div style="margin-bottom:6px;">
                      <CheckBold :size="45" fillColor="#FFA500"></CheckBold>
                    </div>
                    {{ new Date(card.done_at).getFullYear() }}/
                    {{ new Date(card.done_at).getMonth()+1 }}/
                    {{ new Date(card.done_at).getDate() }}
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div @click="closeCardSettingModal">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true" style="font-size:36px;">&times;</span>
            </button>
          </div>
        </div>
      <div class="modal-body" style="background-color:white;">
        <div class="schedule-item">
          <div class="schedule-item-name"
          @click="cardDescriptionEdit"
          style="cursor: pointer;"
          >
            詳細
          </div>
          <div class="schedule-item-content"
          style="cursor:pointer;"
          v-if="!cardDescriptionEditFlag"
          >
            {{ card.description }}
          </div>
        
        </div>

      <div class="schedule-item">
        <div class="schedule-item-name" 
        style="cursor: pointer;"
        >
          期間
        </div>
        <div class="schedule-item-content">
          <div class="schedule-date">
            <div class="schedule-start-date">
              <div>いつから</div>
              <div>
                <div v-if="!card.start">
                  <Pencil></Pencil>
                </div>
                <div v-if="!datePickerFlag&&card.start">
                  {{ new Date(card.start).getFullYear() }}/
                  {{ new Date(card.start).getMonth()+1 }}/
                  {{ new Date(card.start).getDate() }}
                </div>
              </div>  
            </div>
            <div>〜</div>
            <div class="schedule-end-date">
              <div>いつまで</div>
            <div class="datepicker-form">
                <div v-if="!card.deadline">
                  <Pencil></Pencil>
                </div>
                <div v-if="!datePickerFlag&&card.deadline">
                  {{ new Date(card.deadline).getFullYear() }}/
                  {{ new Date(card.deadline).getMonth()+1 }}/
                  {{ new Date(card.deadline).getDate() }}
                </div>
            </div>
            </div>
            </div>
          </div>
        </div>
        </div>

      <div class="modal-footer" style="background-color:white; height:50px;">
          <div class="btn btn-sm btn-secondary" @click="closeCardOfDoneModal">閉じる</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Tag from 'vue-material-design-icons/Tag.vue';
import Pencil from 'vue-material-design-icons/Pencil.vue';

import moment from 'moment'
import ContentSaveEditOutline  from 'vue-material-design-icons/ContentSaveEditOutline.vue';
import PencilOff from 'vue-material-design-icons/PencilOff.vue';
import CardPlus from 'vue-material-design-icons/CardPlus.vue';
import Update from 'vue-material-design-icons/Update.vue';
import CloseCircle from 'vue-material-design-icons/CloseCircle.vue';
import CheckBold from 'vue-material-design-icons/CheckBold.vue';
import Datepicker from 'vuejs-datepicker';
import {ja} from 'vuejs-datepicker/dist/locale'



export default {
  name: 'CardSettingModal',
  data(){
    return{
      ja:ja,
      default: moment().format('YYYY/MM/DD'),
      DatePickerFormat: 'yyyy/MM/dd',
      cardEditFlag: false,
      cardColorEditFlag: false,
      cardDescriptionEditFlag: false,
      cardScheduledEditFlag: false,
      cardStatusEditFlag: false,
      datePickerFlag: false,
    }
  },
  props: {
    card:{
      type: Object
    },
    list:{
      type: Object
    }
  },
  components:{
    Tag,
    Pencil,
    ContentSaveEditOutline,
    PencilOff,
    CardPlus,
    Update,
    CloseCircle,
    Datepicker,
    CheckBold,
  },
  computed:{
  },
  methods:{
    createSchedulesFromCard(){
      this.card.schedulized = true
      this.updateCard()
      this.$emit('clickedCreateScheduleFromCardButton', this.card)
    },
    showDatePicker(){
      this.datePickerFlag = !this.datePickerFlag
    },
    confirmSchedulize(){
      if($('[name="optionsScheduled"] option[value="scheduled"]').prop('selected',true)){
        this.datePickerFlag = true
      }else if($('[name="optionsScheduled"] option[value="scheduled"]').prop('selected',false)){
        this.datePickerFlag = false
      }
    },
    openCardEditModal(){
      this.$emit('clickCardEditOpenButton', this.card)
    },
    closeCardOfDoneModal(){
      this.$emit('clickCardOfDoneModalCloseButton')
    },
    cardDescriptionEdit(){
      this.cardDescriptionEditFlag = true
    },
    cardScheduledEdit(){
      this.cardScheduledEditFlag = true
    },
    cardStatusEdit(){
      this.cardStatusEditFlag = true
    },
    cardEdit(){
      this.cardDescriptionEditFlag = true
      this.datePickerFlag = true
      this.cardColorEditFlag = true
    },
    cardColorEdit(){
      this.cardColorEditFlag = true
      },
    quitCardDescriptionEdit(){
      this.cardDescriptionEditFlag = false
    },
    quitCardColorEdit(){
      this.cardColorEditFlag = false
    },
    quitCardScheduledEdit(){
      this.cardScheduledEditFlag = false
    },
    quitCardStatusEdit(){
      this.cardStatusEditFlag = false
    },
    updateCard(){
      this.$emit('updateCard', this.card)
      this.cardDescriptionEditFlag = false
      this.cardColorEditFlag = false
      this.datePickerFlag = false
    },
    deleteCard(){
      this.$emit('clickedCardDeleteButton', this.card)
    }
  }
}

</script>

<style scoped>
.content{
  z-index:201;
  position:relative;
  top:-140px;
  width:80%;
  padding: 30px;
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
.schedule-created-at-date{
  margin-left:10%;
  display: flex;
}
.schedule-created-at-time{
  margin-left:3%;
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
  font-size:24px;
  text-decoration: underline;
  width:300px;
  text-align: left;
}
.schedule-item-content{
  margin-left: 30px;
  font-size:16px;
  text-align: center;
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

.card-description-editng{
  display: flex;
}

.card-created-at{
  display: flex;
}
.card-updated-at{
  display: flex;
}

.card-scheduled-editng{
  display: flex;
}

.sample2 input[type="text"] {
  width         : 100%;                /* 一旦100%幅     */
  max-width     : 400px;               /* 入力域の最大幅 */
  height        : 47px;                /* 入力域の高さ   */
  background    : #ffffff;             /* 入力域の背景色 */
  border        : 2px solid #87a689;   /* 入力域の枠線   */
  border-radius : 4px;                 /* 入力域の角丸   */
  padding       : 0 20px;              /* 入力文字の余白 */
  font-size     : 16px;                /* 入力文字サイズ */
  color         : #323d33;             /* 入力文字の色   */
  font-weight   : bold;                /* 入力文字の太字 */
  letter-spacing: .1em;                /* 入力文字の間隔 */
  transition    : .2s;       /* ←ここに変化の時間を指定 */
}

/* --- 入力説明の文字(標準) -----------------------------*/
.sample2 input[type="text"]:placeholder-shown {
  color         : #808080;             /* 文字色     */
  font-size     : 14px;                /* 少し小さく     */
 }
/* --- 入力説明の文字(Chrome,Safari,Android,iOS等) ---- -*/
.sample2 input[type="text"]::-webkit-input-placeholder {
  color         : #808080;             /* 文字色     */
  font-size     : 14px;                /* 少し小さく     */
}
/* --- 入力説明の文字(IE用) -----------------------------*/
.sample2 input[type="text"]:-ms-input-placeholder {
  color         : #808080;             /* 文字色         */
  font-size     : 14px;                /* 少し小さく     */
}
/* --- IEの入力エリア右側×消し -------------------------*/
.sample2 input[type="text"]::-ms-clear {
    display     : none;                /* ×を消す       */
}

.cp_ipselect {
overflow: hidden;
width: 90%;
/* margin: 2em auto; */
text-align: center;
font-size: 16px;
}
.cp_ipselect select {
width: 100%;
padding-right: 1em;
cursor: pointer;
text-indent: 0.01px;
text-overflow: ellipsis;
border: none;
outline: none;
background: transparent;
background-image: none;
box-shadow: none;
-webkit-appearance: none;
appearance: none;
}
.cp_ipselect select::-ms-expand {
display: none;
}
.cp_ipselect.cp_sl04 {
position: relative;
border-radius: 2px;
border: 2px solid #87a689;
border-radius: 25px;
background: #ffffff;
}
.cp_ipselect.cp_sl04::before {
position: absolute;
top: 0.8em;
right: 0.8em;
width: 0;
height: 0;
padding: 0;
content: '';
border-left: 6px solid transparent;
border-right: 6px solid transparent;
border-top: 6px solid #da3c41;
pointer-events: none;
}
.cp_ipselect.cp_sl04 select {
padding: 8px 38px 8px 8px;
color: black;
}

.datepicker-form{
  display: flex;
}
</style>
