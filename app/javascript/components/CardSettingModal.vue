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
              <div class="schedule-title" style="font-size:24px; margin-left:10px;width:500px;">
              {{ card.body }}
                <!-- <div 
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
                </div> -->
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
          <div
          @click="cardDescriptionEdit"
          class="schedule-item-content"
          v-if="!card.description&&!cardDescriptionEditFlag">
            <Pencil></Pencil>
          </div>
          <div class="card-description-editng" v-if="cardDescriptionEditFlag"
          style="margin-left:30px;">
            <form  class="description sample2" @submit.prevent="updateCard" style="width:400px;">
            <input v-model="form.description"
            type="text" 
            style="outline:blue;"></input>
            </form>
            <div @click="quitCardDescriptionEdit">
              <CloseCircle :size="30"></CloseCircle>
            </div>
            <div @click="updateCard">
              <ContentSaveEditOutline  :size="30"></ContentSaveEditOutline>
            </div>
          </div>
        </div>

      <div class="schedule-item">
        <div class="schedule-item-name" 
        @click="showDatePicker"
        style="cursor: pointer;"
        >
          期間
        </div>
        <div class="schedule-item-content">
          <div class="schedule-date">
            <div class="schedule-start-date">
              <div>いつから</div>
              <form
              @submit.prevent="updateCard"
              >
                <div v-if="!card.start" @click="showDatePicker">
                  <Pencil></Pencil>
                </div>
                <div v-if="!datePickerFlag&&card.start" @click="showDatePicker">
                  {{ new Date(card.start).getFullYear() }}/
                  {{ new Date(card.start).getMonth()+1 }}/
                  {{ new Date(card.start).getDate() }}
                </div>
                <div v-if="datePickerFlag&&!card.schedulized">
                    <Datepicker
                    :language="ja"
                    class="test"
                    :value="this.default"
                    :format="DatePickerFormat"
                    v-model="form.start"
                    ></Datepicker>
                </div>
              </form>
              <div v-if="validationOfStart" style="color:red;">{{ validationOfStart }}</div>
              <div v-if="validationOfPastSetting" style="color:red;">{{ validationOfPastSetting }}</div>
              <!-- <div>{{.start_yyyymmdd}}</div> -->
            </div>
            <div>〜</div>
            <div class="schedule-end-date">
              <div>いつまで</div>
            <div class="datepicker-form">
              <form 
              @submit.prevent="updateCard"
              >
                <div v-if="!card.deadline" @click="showDatePicker">
                  <Pencil></Pencil>
                </div>
                <div v-if="!datePickerFlag&&card.deadline" @click="showDatePicker">
                  {{ new Date(card.deadline).getFullYear() }}/
                  {{ new Date(card.deadline).getMonth()+1 }}/
                  {{ new Date(card.deadline).getDate() }}
                </div>
                <div v-if="datePickerFlag&&!card.schedulized">
                  <Datepicker
                  :language="ja" 
                  class="test"
                  :value="this.default"
                  :format="DatePickerFormat"
                  v-model="form.deadline"
                  ></Datepicker>
                </div>
              </form>
              <div style="position:relative;left:-10px;width:200px;font-size:15px;color:red;"
              v-if="validationOfDeadline">
                {{validationOfDeadline}}
              </div>
              <div
               v-if="datePickerFlag&&!card.schedulized"
               @click="showDatePicker"
               style="position:relative;left:120px;bottom:30px;"
               >
                <CloseCircle :size="30"></CloseCircle>
              </div>
              <div 
              v-if="datePickerFlag&&!card.schedulized" 
              @click="updateCard"
              style="position:relative;left:150px;bottom:60px;"
              >
                <ContentSaveEditOutline  :size="30"></ContentSaveEditOutline>
              </div>
            </div>
            </div>
            </div>
          </div>
        </div>

      <div class="schedule-item" v-if="card.done">
        <div class="schedule-item-name" 
        @click="showDatePicker"
        style="cursor: pointer;"
        >
          完了日
        </div>
        <div class="schedule-item-content">
          <div class="schedule-date">
            {{ new Date(card.done_at).getFullYear() }}/
            {{ new Date(card.done_at).getMonth()+1 }}/
            {{ new Date(card.done_at).getDate() }}
          </div>
        </div>
        
        <div class="schedule-item" v-if="!card.done">
          <div class="schedule-item-name"
          @click="cardColorEdit"
          style="cursor: pointer;"
          >
            カードの色
          </div>
          <div 
          style="cursor:pointer;"
          @click="cardColorEdit"
          >
            <div class="schedule-item-content" v-if="card.color==='#FFD5EC'&&!cardColorEditFlag">
              <div style="width:50px; height:50px; background-color:#FFD5EC;"></div>
            </div>
            <div class="schedule-item-content" v-if="card.color==='#CBFFD3'&&!cardColorEditFlag">
              <div style="width:50px; height:50px; background-color:#CBFFD3;"></div>
            </div>
            <div class="schedule-item-content" v-if="card.color==='#CCFFFF'&&!cardColorEditFlag">
              <div style="width:50px; height:50px; background-color:#CCFFFF;"></div>
            </div>
          </div>
          <div class="card-scheduled-editng" v-if="cardColorEditFlag"
          style="margin-left:25px;">
            <form  class="scheduled cp_ipselect cp_sl04" 
            @submit.prevent="updateCard"
            style="width:400px;">
            <select v-model="form.color"
            type="text" 
            style="outline:blue;">
               <option value="#FFD5EC">
                  ピンク
                </option>
                <option value="#CBFFD3">
                  緑
                </option>
                <option value="#CCFFFF">
                  水色
                </option>
            </select>
            </form>
            <div @click="quitCardColorEdit">
              <CloseCircle :size="30"></CloseCircle>
            </div>
            <div @click="updateCard"
             style="cursor: pointer;"
            >
              <ContentSaveEditOutline  :size="30"></ContentSaveEditOutline>
            </div>
          </div>
        </div>
      </div>

        <!-- <div class="schedule-item">
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
        </div> -->
        
        <div class="schedule-item">
          <div class="schedule-item-name"
          @click="cardColorEdit"
          style="cursor: pointer;"
          >
            カードの色
          </div>
          <div 
          style="cursor:pointer;"
          @click="cardColorEdit"
          >
            <div class="schedule-item-content" v-if="card.color==='#FFD5EC'&&!cardColorEditFlag">
              <div style="width:50px; height:50px; background-color:#FFD5EC;"></div>
            </div>
            <div class="schedule-item-content" v-if="card.color==='#CBFFD3'&&!cardColorEditFlag">
              <div style="width:50px; height:50px; background-color:#CBFFD3;"></div>
            </div>
            <div class="schedule-item-content" v-if="card.color==='#CCFFFF'&&!cardColorEditFlag">
              <div style="width:50px; height:50px; background-color:#CCFFFF;"></div>
            </div>
          </div>
          <div class="card-scheduled-editng" v-if="cardColorEditFlag"
          style="margin-left:25px;">
            <form  class="scheduled cp_ipselect cp_sl04" 
            @submit.prevent="updateCard"
            style="width:400px;">
            <select v-model="form.color"
            type="text" 
            style="outline:blue;">
               <option value="#FFD5EC">
                  ピンク
                </option>
                <option value="#CBFFD3">
                  緑
                </option>
                <option value="#CCFFFF">
                  水色
                </option>
            </select>
            </form>
            <div 
            @click="quitCardColorEdit"
             style="cursor: pointer;position:relative;top:5px;"
            >
              <CloseCircle :size="30"></CloseCircle>
            </div>
            <div @click="updateCard"
             style="cursor: pointer;position:relative;top:5px;"
            >
              <ContentSaveEditOutline  :size="30"></ContentSaveEditOutline>
            </div>
          </div>
        </div>
      </div>

      </div>
      <div class="modal-footer" style="background-color:white; height:50px;">
          <div class="btn btn-sm btn-secondary" @click="closeCardSettingModal">閉じる</div>
          <div class="btn btn-sm btn-primary" @click="cardEdit">編集する</div>
          <div class="btn btn-sm btn-outline-warning" v-if="!card.schedulized" @click="createSchedulesFromCard">ガントチャートに追加する</div>
          <!-- <div class="btn btn-lg btn-danger" @click="deleteCard">このToDoカードを削除する</div> -->
      </div>
      <div v-if="CannotSubmitMessage" style="color:red;position:relative;left:930px;">
        {{CannotSubmitMessage}}
      </div>
      <!-- <div><pre><code>{{card}}</code></pre></div>
      <div>{{start}}</div>
      <div>{{deadline}}</div>
      <div>{{ validDate }}</div> -->
      <!-- <div>{{ new Date() }}</div>
      <div><pre><code>{{form}}</code></pre></div> -->
      <!-- <div>{{logic}}</div> -->
      <div>{{form}}</div>
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
      form:{
        id: this.card.id,
        body: this.card.body,
        description: this.card.description,
        start: '',
        deadline: '',
        schedulized: this.card.schedulized,
        color: this.card.color,
        card_id: this.card.id,
        user_id: this.$store.getters['auth/user'].id,
      },
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
  },
  computed:{
    // logic(){
    //   return moment(this.form.start).format('YYYY/MM/DD') === moment().format('YYYY/MM/DD')&&moment(this.form.deadline).format('YYYY/MM/DD') === moment().format('YYYY/MM/DD')
    // },
    validationOfStart(){
      if(this.form.start > this.form.deadline&&this.form.deadline!==''){
        return '設定できません'
      }
    },
    validationOfDeadline(){
      if((this.form.deadline - this.form.start)/86400000 > 7&&this.form.start!==''){
        return '1週間より長い予定は設定できません'
      }
    },
    validationOfPastSetting(){
      if(moment(this.form.start).format('YYYY/MM/DD') < moment().format('YYYY/MM/DD')&&this.form.start!==''){
        return '過去の日付は設定できません'
      }
    },
    CannotSubmitMessage(){
      if(this.form.start > this.form.deadline&&this.form.deadline!==''){
        return '追加できません'
      }

      if((this.form.deadline - this.form.start)/86400000 > 7&&this.form.start!==''){
        return '追加できません'
      }

      if(moment(this.form.start).format('YYYY/MM/DD') < moment().format('YYYY/MM/DD')&&this.form.start!==''){
        return '追加できません'
      }
    }
  },
  methods:{
    createSchedulesFromCard(){
      if(moment(this.form.start).format('YYYY/MM/DD') === moment().format('YYYY/MM/DD')&&moment(this.form.deadline).format('YYYY/MM/DD') === moment().format('YYYY/MM/DD')){
        this.form.schedulized = true
        this.updateCard()
        this.$emit('clickedCreateScheduleFromCardButton', this.form)
      }
      else if(this.form.start > this.form.deadline&&this.form.deadline!==''){
        return '追加できません'
      }
      else if((this.form.deadline - this.form.start)/86400000 > 7&&this.form.start!==''){
        return '追加できません'
      }
      else if(this.form.start < moment()&&this.form.start!==''){
        return '追加できません'
      }
      else {
        this.form.schedulized = true
        this.updateCard()
        this.$emit('clickedCreateScheduleFromCardButton', this.form)
      }
    },
    showDatePicker(){
      this.datePickerFlag = !this.datePickerFlag
    },
    // confirmSchedulize(){
    //   if($('[name="optionsScheduled"] option[value="scheduled"]').prop('selected',true)){
    //     this.datePickerFlag = true
    //   }else if($('[name="optionsScheduled"] option[value="scheduled"]').prop('selected',false)){
    //     this.datePickerFlag = false
    //   }
    // },
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
      this.$emit('updateCard', this.form)
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
  position: relative;
  left: -100px;
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
  /* display: flex; */
}
</style>
