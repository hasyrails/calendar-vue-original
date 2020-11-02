<template>
<div>
  <div class="user-info-page" v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0">
    <div class="user-info">
      <div class="user-info-title">ユーザー情報</div>
      <div class="user-info-content">
        <div class="user-name-item">
          ユーザー名：
        </div>
        <div class="user-name">
          {{ $store.state.auth.user.name }}さん
        </div>
      </div>
      <div class="user-info-content">
        <div class="user-email-item">
          メールアドレス：
        </div>
        <div class="user-email">
          {{ $store.state.auth.user.email }}
        </div>
      </div>
      <div class="user-info-content">
        <div class="user-image-item">
          ユーザーアイコン：
        </div>
        <div>
          <div class="user-image" v-if="src">
            <div v-if="$store.state.srcFlag">
              <img style="border-radius:50%;" :src="src" width="100" height="100">
            </div>
            <div style="font-size:10px;">
              <UserIconUpdateForm></UserIconUpdateForm>
            </div>
          </div>
          <div class="alternative-user-image" v-if="!src" style="display:flex;">
              <Account :size="100" fillColor="#2C7CFF"></Account>
            <div style="font-size:10px;">
              <UserIconUpdateForm></UserIconUpdateForm>
            </div>
          </div>
        </div>
      </div>
      <div class="user-info-content">
        <div class="schedulized-cards-item">
          進行中のタスク数：
        </div>
        <div class="schedulized-cards">
        {{ schedulizedCardsCount }}
        </div>
      </div>
      <div class="user-info-content">
        <div class="finished-cards-item">
          期限を護ったタスクの数：
        </div>
        <div class="finished-cards">
        {{ doneCardsCount }}
        </div>
      </div>
      <div class="user-info-content">
        <div class="deadlined-cards-item">
          期限をﾏﾓﾚﾅｶｯﾀ‥タスクの数：
        </div>
        <div class="deadlined-cards">
        {{ deadlinedCardsCount }}
        </div>
      </div>
      <div class="counted-cards">
        合計：{{ countedCardsCount }}
      </div>
      <div class="user-info-content">
        <div class="user-graph-item">
          初志の勝率：
        </div>
        <div class="user-graph purun">
          {{percentage}} 
          <div v-if="zeroDevideZeroFlag" style="position:fixed;top:15%;display:flex;">
            <Numeric0 :size="130" fillColor="#A4C6FF"></Numeric0>
            <SlashForward :size="130" fillColor="#A4C6FF"></SlashForward>
            <Numeric0 :size="130" fillColor="#A4C6FF"></Numeric0>
          </div>
        </div>
      </div>
      <div class="graph">
        <UserInfoGraph></UserInfoGraph>
      </div>
    </div>
  </div>

  <div class="user-info-page" v-if="this.$store.state.auth.headers.length===0&&this.$store.state.auth.user.length!==0">
    <div class="user-info">
      <div class="user-info-title">ユーザー情報</div>
      <div class="user-info-content">
        <div class="user-name-item">
          ユーザー名：
        </div>
        <div class="user-name">
          {{ $store.state.auth.user.name }}さん
        </div>
      </div>
      <div class="user-info-content">
        <div class="user-email-item">
          メールアドレス：
        </div>
        <div class="user-email">
          {{ $store.state.auth.user.email }}
        </div>
      </div>
      <div class="user-info-content">
        <div class="user-image-item">
          ユーザーアイコン：
        </div>
        <div class="guest-user-image">
          <Account :size="100" fillColor="#2C7CFF"></Account>
        </div>
      </div>
      <div class="user-info-content">
        <div class="schedulized-cards-item">
          進行中のタスク数：
        </div>
        <div class="guest-schedulized-cards">
          <Key :size="50" fillColor="#FFC7AF"></Key>
        </div>
      </div>
      <div class="user-info-content">
        <div class="finished-cards-item">
          期限を護ったタスクの数：
        </div>
        <div class="guest-finished-cards">
          <Key :size="50" fillColor="#FFC7AF"></Key>
        </div>
      </div>
      <div class="user-info-content">
        <div class="deadlined-cards-item">
          期限をﾏﾓﾚﾅｶｯﾀ‥タスクの数：
        </div>
        <div class="guest-deadlined-cards">
          <Key :size="50" fillColor="#FFC7AF"></Key>
        </div>
      </div>
      <div class="guest-counted-cards">
        合計：<Key :size="50" fillColor="#FFC7AF"></Key>
      </div>
      <div class="user-info-content">
        <div class="user-graph-item">
          初志の勝率：
        </div>
        <div class="guest-user-graph purun">
          <Key :size="150" fillColor="#FFC7AF"></Key>  %
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import Account from 'vue-material-design-icons/Account.vue';
import Key from 'vue-material-design-icons/Key.vue';
import Numeric0  from 'vue-material-design-icons/Numeric0.vue';
import SlashForward  from 'vue-material-design-icons/SlashForward.vue';

import UserInfoGraph from '../components/UserInfoGraph.vue'
import UserIconUpdateForm from '../components/UserIconUpdateForm.vue'

export default {
  data(){
    return{
      src: this.$store.state.auth.user.image,
      alternativeUserIconFlag: this.$store.getters.alternativeUserIconFlag
    }
  },
  components:{
    UserInfoGraph,
    Account,
    Key,
    UserIconUpdateForm,
    Numeric0,
    SlashForward,
  },
  methods:{
  },
  computed:{
    percentage(){
      if(this.doneCardsCount + this.deadlinedCardsCount!==0){
        return ((this.doneCardsCount/(this.doneCardsCount + this.deadlinedCardsCount))*100 + '%')
      }else{
        return ''
      }
    },
    zeroDevideZeroFlag(){
      if(this.doneCardsCount + this.deadlinedCardsCount===0){
        return true
      }else{
        return false
      }
    },
    countedCardsCount(){
      return this.doneCardsCount + this.deadlinedCardsCount
    },
    schedulizedCardsCount() {
       return this.$store.getters['cards/schedulizedCards'].length
    },
    deadlinedCardsCount() {
      return this.$store.getters['cards/deadlinedCards'].length
    },
    doneCardsCount() {
      return this.$store.getters['cards/doneCards'].length
    },
  },
  mounted(){
    this.$store.dispatch('cards/fetchCardsAction')
  },
}
</script>

<style scoped>
.user-info-page{
/* background: #EEFFFF; */
width: 100%;
height: 100%;
background: #EEFFFF;
/* width: 100%;
height: 100%; */
}

.user-info{
  width: 90%;
  margin-left:5%;
  margin-right:5%;
} 
.user-info-title{
  position: fixed;
  top: 12%;
  left: 5%;
  font-size: 40px;
} 

.user-name-item{
  position: fixed;
  top: 18%;
  left: 8%;
  font-size: 30px;
}
.user-name{
  position: fixed;
  top: 19%;
  left: 25%;
  font-size: 25px;
}
.user-email-item{
  position: fixed;
  top: 23%;
  left: 8%;
  font-size: 30px;
}
.user-email{
  position: fixed;
  top: 23%;
  left: 25%;
  font-size: 25px;
}
.user-image-item{
  position: fixed;
  top: 30%;
  left: 8%;
  font-size: 30px;
}
.user-image{
  position: fixed;
  top: 28%;
  left: 27%;
  font-size: 30px;
}
.alternative-user-image{
  position: fixed;
  top: 33%;
  left: 25%;
  font-size: 40px;

}
.guest-user-image{
  position: fixed;
  top: 33%;
  left: 28%;
  font-size: 40px;
}
.user-graph-item{
  position: fixed;
  top: 11%;
  left: 45%;
  font-size: 80px;
}
.user-graph{
  position: fixed;
  top: 11%;
  left: 77%;
  font-size: 80px;
}
.guest-user-graph{
  position: fixed;
  top: 8%;
  left: 80%;
  font-size: 100px;
}
.finished-cards-item{
  position: fixed;
  top: 25%;
  left: 48%;
  font-size: 30px;
}
.finished-cards{
  position: fixed;
  top: 25%;
  left: 73%;
  font-size: 30px;
}
.guest-finished-cards{
  position: fixed;
  top: 25%;
  left: 73%;
  font-size: 30px;
}
.deadlined-cards-item{
  position: fixed;
  top: 33%;
  left: 48%;
  font-size: 30px;
}
.deadlined-cards{
  position: fixed;
  top: 33%;
  left: 75%;
  font-size: 30px;
}
.guest-deadlined-cards{
  position: fixed;
  top: 33%;
  left: 75%;
  font-size: 30px;
}
.schedulized-cards-item{
  position: fixed;
  top:44%;
  left: 48%;
  font-size: 30px;
}
.schedulized-cards{
  position: fixed;
  top: 44%;
  left: 67%;
  font-size: 30px;
}
.guest-schedulized-cards{
  position: fixed;
  top: 44%;
  left: 67%;
  font-size: 30px;
}
.counted-cards{
  position: fixed;
  top: 29%;
  left: 80%;
  font-size: 30px;
}
.guest-counted-cards{
  position: fixed;
  top: 33%;
  left: 83%;
  font-size: 30px;
}
.graph{
  position: fixed;
  left: 5%;
  top: 52%;
}

.purun {
  animation: purun 0.8s linear 0s 1;
}

@keyframes purun {
  0%   { transform: scale(1.0, 1.0) translate(0%, 0%); }
  15%  { transform: scale(0.9, 0.9) translate(0%, 5%); }
  30%  { transform: scale(1.3, 0.8) translate(0%, 10%); }
  50%  { transform: scale(0.8, 1.3) translate(0%, -10%); }
  70%  { transform: scale(1.1, 0.9) translate(0%, 5%); }
  100% { transform: scale(1.0, 1.0) translate(0%, 0%); }
}
</style>
