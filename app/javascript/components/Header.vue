<template>
  <div class="app-header">
    <div class="app-header-contents">
      <router-link to="/">
        <div class="app-header-title">初志しか勝たん<BoxingGlove :size="70"></BoxingGlove>{{$store.state.auth.user}}</div>
        <!-- <p class="app-header-title-footer">初志貫徹アプリ</p> -->
      </router-link>
      <router-link to="/userinfo">
        <div class="user-icon" v-if="$store.state.auth.headers">
          <img style="border-radius:50%;" :src="src" width="100" height="100">
        </div>
        <div class="user-icon" v-if="$store.state.auth.user&&!$store.state.auth.headers">
          <Account :size="120"></Account>
        </div>
      </router-link>
        <div class="user-name" v-if="$store.state.auth.headers">
          {{ this.$store.state.auth.user.user.data.name }}さん
        </div>
        <div class="user-name" v-if="$store.state.auth.user&&!$store.state.auth.headers">
          {{ this.$store.state.auth.user.user.name }}さん
        </div>
      <div v-if="!$store.state.auth.user">
        <div class="app-header-link-guest-login" @click="guestLogin">ゲストログイン</div>
      </div>
      <div v-if="$store.state.auth.user&&!$store.state.auth.headers">
        <div class="app-header-link-guest-logout" @click="guestLogOut">ログアウト（ゲスト）</div>
      </div>
      <div class="app-header-link unlogin-user-link" v-if="!$store.state.auth.headers">
        <router-link to="/register">
          <div class="app-header-link-register">ユーザー登録</div>
        </router-link>
        <router-link to="/login">
          <div class="app-header-link-login">ログイン</div>
        </router-link>
      </div>
      <div class="app-header-link unlogin-user-link" v-if="$store.state.auth.headers">
        <!-- <router-link to="/register">
          <div class="app-header-link-register">ユーザー登録</div>
        </router-link> -->
          <div class="app-header-link-logout" @click="logout">ログアウト</div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex'
import BoxingGlove from 'vue-material-design-icons/BoxingGlove.vue';
import Account from 'vue-material-design-icons/Account.vue';

  export default {
    name: 'Header',
    data(){
      return{
        users:{},
        src: this.$store.state.auth.user.user.data.image
      }
    },
    components:{
      BoxingGlove,
      Account,
    },
    methods:{
      logout(){
        if(confirm('ログアウトしますか？')){
          this.$store.dispatch('auth/signOut')
          this.$store.dispatch('auth/guestLogOutAction')
        }
      },
      guestLogin(){
        this.$store.dispatch('auth/guestLoginAction')
      },
      guestLogOut(){
        this.$store.dispatch('auth/guestLogOutAction')
      }
    }
  }

</script>

<style scoped>
.app-header{
  background: hsl(180, 65%, 81%);
  height: 150px;
  color: black;
  font-style: italic;
  /* text-align: left; */
  /* padding: 20px; */
  position:absolute;
  top: 0px;
  width:100vw;
  position: fixed;
  /* z-index: 2; */
}

.app-header-contents{
  display:flex;
}

.app-header-title{
  margin-top:40px;
  margin-left:20%;
  margin-right:10px;
  font-size: 60px;
  font-weight: 30px;
  font-family: "Hiragino Sans","ヒラギノ角ゴシック"; font-weight: 900;
  color: black;
  width:500px;
}
.app-header-title-footer{
  margin-left:20%;
  margin-right:10px;
  font-size: 20px;
  font-weight: 30px;
  font-family: "Hiragino Sans","ヒラギノ角ゴシック"; font-weight: 900;
  color: black;
  width:500px;
}
.app-header-link{
  /* display:flex;
  margin-left:55%;
  margin-right:10px;
  margin-top:40px;
  float: right; */
  font-size: 40px;
  font-weight: 30px;
  /* justify-content: space-between; */
}

.app-header-link-guest-login{
  font-size: 40px;
  position:fixed;
  top:3%;
  left:68%;
  color: black;
  cursor: pointer;
}
.app-header-link-guest-logout{
  font-size: 40px;
  position:fixed;
  top:3%;
  left:63%;
  color: black;
  cursor: pointer;
}

.app-header-link-register{
  /* margin-left:10px; */
  /* margin-right:100px; */
  position:fixed;
  top:3%;
  left:79%;
  color: black;
  cursor: pointer;
  /* width:200px; */
}
.app-header-link-login{
  /* margin-left:10px; */
  /* margin-right:10px; */
  position:fixed;
  top:3%;
  left:90%;
  color: black;
  cursor: pointer;
  /* width:300px; */
}
.app-header-link-logout{
  /* margin-left:10px; */
  /* margin-right:10px; */
  position:fixed;
  top:3%;
  left:90%;
  color: black;
  cursor: pointer;
  /* width:300px; */
}
.user-icon{
  position:fixed;
  top:1%;
  right:50%;
}
.user-name{
  position:fixed;
  top:7%;
  right:50%;
  font-size: 30px;
}
</style>
