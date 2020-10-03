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
                class="card-created-at"
                v-if="card.created_at===card.update_at">
                  <div class="schedule-created-at-date" style="width:300px;">
                    <div style="margin-bottom:6px;">
                      <CardPlus :size="45"></CardPlus>
                    </div>
                    {{ new Date(card.created_at).getFullYear() }}/
                    {{ new Date(card.created_at).getMonth()+1 }}/
                    {{ new Date(card.created_at).getDate() }}
                  </div>
                  <div class="schedule-created-at-time" style="width:200px;">
                    {{ new Date(card.created_at).getHours() }}:
                    {{ new Date(card.created_at).getMinutes() }}
                  </div>
                </div>
                <div 
                class="card-updated-at"
                v-if="card.created_at!==card.update_at">
                  <div class="schedule-created-at-date" style="width:300px;">
                    <div style="margin-bottom:6px;">
                      <Update :size="45"></Update>
                    </div>
                    {{ new Date(card.updated_at).getFullYear() }}/
                    {{ new Date(card.updated_at).getMonth()+1 }}/
                    {{ new Date(card.updated_at).getDate() }}
                  </div>
                  <div class="schedule-created-at-time" style="width:200px;">
                    {{ new Date(card.updated_at).getHours() }}:
                    {{ new Date(card.updated_at).getMinutes() }}
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
          <div class="card-description-editng" v-if="cardDescriptionEditFlag"
          style="margin-left:30px;">
            <form  class="description sample2" @submit.prevent="updateCard" style="width:400px;">
            <input v-model="card.description"
            type="text" 
            style="outline:blue;"></input>
            </form>
            <div @click="quitCardDescriptionEdit">
              <CloseCircle :size="45"></CloseCircle>
            </div>
            <div @click="updateCard">
              <ContentSaveEditOutline  :size="45"></ContentSaveEditOutline>
            </div>
          </div>
        </div>

        <div class="schedule-item">
          <div class="schedule-item-name"
          @click="cardScheduledEdit"
          style="cursor: pointer;"
          >
            ガントチャートへ
          </div>
          <div class="schedule-item-content" 
          style="cursor:pointer;"
          >
            <div
            v-if="card.scheduled==='non_scheduled'&&!cardScheduledEditFlag"
            >
              non_scheduled
            </div>
            <div
            v-if="card.scheduled==='scheduled'&&!cardScheduledEditFlag"
            >
              scheduled
            </div>
          </div>
           <div class="card-scheduled-editng" v-if="cardScheduledEditFlag">
            <form
            class="scheduled cp_ipselect cp_sl04"
            @submit.prevent="updateCard"
            style="width:400px;"
            >
            <select v-model="card.scheduled"
            type="text"
            name="optionsScheduled"
            style="outline:blue;"
            @change="confirmSchedulize"
            >
               <option value="scheduled">
                  shcduled
                </option>
                <option value="non_scheduled">
                  non_scheduled
                </option>
            </select>
            </form>
            <div @click="quitCardScheduledEdit">
              <CloseCircle :size="45"></CloseCircle>
            </div>
            <div @click="updateCard">
              <ContentSaveEditOutline  :size="45"></ContentSaveEditOutline>
            </div>
          </div>
        </div> -->

      <div class="schedule-item">
        <div class="schedule-item-name">期間</div>
        <div class="schedule-item-content">
          <div class="schedule-date">
            <div class="schedule-start-date">
              <div>始める日</div>
              <div>
              <form
              @submit.prevent="updateCard"
              >
                <div v-if="!datePickerFlag" @click="showDatePicker">
                  {{ card.start }}
                </div>
                <div v-if="datePickerFlag">
                    <Datepicker
                    :language="ja"
                    class="test"
                    :value="this.default"
                    :format="DatePickerFormat"
                    v-model="card.start"
                    ></Datepicker>
                </div>
              </form>
              </div>
              <!-- <div>{{.start_yyyymmdd}}</div> -->
            </div>
            <div>〜</div>
            <div class="schedule-end-date">
              <div>終わらせる日</div>
              <div>
              <form 
              @submit.prevent="updateCard"
              >
                <div v-if="!datePickerFlag" @click="showDatePicker">
                  {{ card.end }}
                </div>
                <div v-if="datePickerFlag">
                  <Datepicker
                  :language="ja" 
                  class="test"
                  :value="this.default"
                  :format="DatePickerFormat"
                  v-model="card.end"
                  ></Datepicker>
                </div>
              </form>
              </div>
              <!-- <div>{{schedule.end_yyyymmdd}}</div> -->
            </div>
            </div>
          </div>
        </div>
        
        <div class="schedule-item">
          <div class="schedule-item-name"
          @click="cardStatusEdit"
          style="cursor: pointer;"
          >
            ステータス
          </div>
          <div 
          style="cursor:pointer;"
          >
            <div class="schedule-item-content" v-if="card.status==='todo'&&!cardStatusEditFlag">
            ToDo
            </div>
            <div class="schedule-item-content" v-if="card.status==='doing'&&!cardStatusEditFlag">
            Doing
            </div>
            <div class="schedule-item-content" v-if="card.status==='done'&&!cardStatusEditFlag">
            Done
            </div>
          </div>
          <div class="card-scheduled-editng" v-if="cardStatusEditFlag"
          style="margin-left:25px;">
            <form  class="scheduled cp_ipselect cp_sl04" 
            @submit.prevent="updateCard"
            style="width:400px;">
            <select v-model="card.status"
            type="text" 
            style="outline:blue;">
               <option value="todo">
                  ToDo
                </option>
                <option value="doing">
                  Doing
                </option>
                <option value="done">
                  Done
                </option>
            </select>
            </form>
            <div @click="quitCardStatusEdit">
              <CloseCircle :size="45"></CloseCircle>
            </div>
            <div @click="updateCard">
              <ContentSaveEditOutline  :size="45"></ContentSaveEditOutline>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer" style="background-color:white; height:100px;">
          <div class="btn btn-lg btn-secondary" @click="closeCardSettingModal">閉じる</div>
          <div class="btn btn-lg btn-primary" @click="cardEdit">編集する</div>
          <div class="btn btn-lg btn-primary" @click="createSchedulesFromCard">ガントチャートに追加する</div>
          <div class="btn btn-lg btn-danger" @click="deleteCard">このToDoカードを削除する</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Tag from 'vue-material-design-icons/Tag.vue';
import moment from 'moment'
import ContentSaveEditOutline  from 'vue-material-design-icons/ContentSaveEditOutline.vue';
import PencilOff from 'vue-material-design-icons/PencilOff.vue';
import CardPlus from 'vue-material-design-icons/CardPlus.vue';
import Update from 'vue-material-design-icons/Update.vue';
import CloseCircle from 'vue-material-design-icons/CloseCircle.vue';
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
    ContentSaveEditOutline,
    PencilOff,
    CardPlus,
    Update,
    CloseCircle,
    Datepicker,
  },
  computed:{
    // schedule: {
    //     title: this.card.body,
    //     start: this.card.start,
    //     end: this.card.end
    //   },
  },
  methods:{
    confirmSchedulize(){
      if($('[name="optionsScheduled"] option[value="scheduled"]').prop('selected',true)){
        window.alert('hoge');
      }else if($('[name="optionsScheduled"] option[value="non-scheduled"]').prop('selected',true)){
        window.alert('fuga');
      }
    },
    openCardEditModal(){
      this.$emit('clickCardEditOpenButton', this.card)
    },
    closeCardSettingModal(){
      this.$emit('clickCardSettingModalCloseButton')
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
      this.cardScheduledEditFlag = true
      this.cardStatusEditFlag = true
    },
    quitCardDescriptionEdit(){
      this.cardDescriptionEditFlag = false
    },
    quitCardScheduledEdit(){
      this.cardScheduledEditFlag = false
    },
    quitCardStatusEdit(){
      this.cardStatusEditFlag = false
    },
    updateCard(){
      this.cardDescriptionEditFlag = false
      this.$emit('updateCard', this.card)
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
  font-size:36px;
  text-decoration: underline;
  width:300px;
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
  font-size     : 26px;                /* 入力文字サイズ */
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
font-size: 26px;
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
</style>
