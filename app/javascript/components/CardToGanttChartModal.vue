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
          <div @click="closeCardToGanttChartModal">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true" style="font-size:36px;">&times;</span>
            </button>
          </div>
        </div>
      <div class="modal-body" style="background-color:white;">
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
                <Datepicker
                :language="ja"
                class="test"
                :value="this.default"
                :format="DatePickerFormat"
              v-model="card.start"
                ></Datepicker>
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
                <Datepicker
                :language="ja" 
                class="test"
                :value="this.default"
                :format="DatePickerFormat"
              v-model="card.end"
                ></Datepicker>
              </form>
              </div>
              <!-- <div>{{schedule.end_yyyymmdd}}</div> -->
            </div>
            </div>
          </div>

            <div @click="quitCardScheduledEdit">
              <CloseCircle :size="45"></CloseCircle>
            </div>
            <div @click="updateCard">
              <ContentSaveEditOutline  :size="45"></ContentSaveEditOutline>
            </div>
          </div>
        </div>
       
      <div class="modal-footer" style="background-color:white; height:100px;">
          <div class="btn btn-lg btn-secondary" @click="closeCardToGanttChartModal">閉じる</div>
          <div class="btn btn-lg btn-primary" @click="cardEdit">編集する</div>
          <div class="btn btn-lg btn-danger" @click="deleteCard">このToDoカードを削除する</div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import CardAdd from '../components/CardAdd'
import Card from '../components/Card'
import CardSettingModal from '../components/CardSettingModal'
import CardToGanttChartModal from '../components/CardToGanttChartModal'


import draggable from "vuedraggable";
import Datepicker from 'vuejs-datepicker';
import {ja} from 'vuejs-datepicker/dist/locale'
import moment from 'moment'

import { mapState, mapActions } from 'vuex'

export default {
  data(){
    return{
      ja:ja,
      default: moment().format('YYYY/MM/DD'),
      DatePickerFormat: 'yyyy/MM/dd',
      options: {
        group: {
          name: 'myGroup',
          // pull: 'clone',
          // put: 'clone'
        },
        animation: 200
      },
      cardSettingModalFlag: false,
      cardEditModalFlag: false,
    }
  },
  props: {
    // id: {
    //   type: Number,
    //   required: true
    // },
    // title: {
    //   type: String,
    //   required: true
    // },
    list: {
      type: Object,
      required: true
    },
    card: {
      type: Object,
      required: true
    },
    schedule: {
      type: Object,
      required: true
    },
    // listIndex: {
    //   type: Number,
    //   required: true
    // }
  },
  computed: {
    // totalCardInList() {
    //   return this.cards.length
    // }
    ...mapState('cards',{
      cards: 'cards'
    }),
    
    // ...mapState('lists',{
    //   lists: 'lists'
    // }),
  },
  mounted(){
    this.$store.dispatch('cards/fetchCardsAction')
  },
  components:{
    CardAdd,
    Card,
    CardSettingModal,
    // CardEditModal,
    CardToGanttChartModal,
    draggable,
    Datepicker
  },
  methods: {
    ...mapActions('cards',[
      'updateCardAction',
      'deleteCardAction',
    ]),
    closeCardToGanttChartModal(){
      this.$emit('clickedCloseCardToGanttChartButton')
    },
    updateCard(){
      this.$emit('datePickerInputted', this.card)
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
