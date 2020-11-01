<template>
<div>
  <div class="app-header" v-if="this.$route.path!=='/schedules'">
    <div class="app-header-contents">
      <router-link to="/">
        <div class="app-header-title">初志しか勝たん<BoxingGlove size="30"></BoxingGlove></div>
        <!-- <p class="app-header-title-footer">初志貫徹アプリ</p> -->
      </router-link>
      <router-link to="/userinfo">
        <div class="user-icon" v-if="$store.state.auth.headers">
          <img style="border-radius:50%;" :src="src" width="70" height="70">
        </div>
      </router-link>
        <div class="user-name" v-if="$store.state.auth.headers">
          {{ this.$store.state.auth.user.name }}さん
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

  <div class="app-header" v-if="this.$route.path==='/schedules'" style="width:400%;">
    <div class="app-header-contents">
      <router-link to="/">
        <div class="app-header-title">初志しか勝たん<BoxingGlove :size="30"></BoxingGlove></div>
        <!-- <p class="app-header-title-footer">初志貫徹アプリ</p> -->
      </router-link>
      <router-link to="/userinfo">
        <div class="user-icon" v-if="$store.state.auth.headers">
          <img style="border-radius:50%;" :src="src" width="70" height="70">
        </div>
      </router-link>
        <div class="user-name" v-if="$store.state.auth.headers">
          {{ this.$store.state.auth.user.name }}さん
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
</div>
</template>

<script>
import {mapState} from 'vuex'
import BoxingGlove from 'vue-material-design-icons/BoxingGlove.vue';

  export default {
    name: 'Header',
    data(){
      return{
        users:{},
        src: this.$store.getters['auth/user'].image
      }
    },
    components:{
      BoxingGlove,
    },
    methods:{
      logout(){
        if(confirm('ログアウトしますか？')){
          this.$store.dispatch('auth/signOut')
        }
      }
    }
  }

</script>

<style scoped>
a {
  color: black;
  text-decoration: none;
}

.app-header{
  background-color: #FFDBC9;
  height: 100px;
  color: black;
  font-style: italic;
  /* text-align: left; */
  /* padding: 20px; */
  width:100%;
  /* z-index: 2; */
}

.ganttchart-page-header{
  width:450%;
}

.app-header-contents{
  display:flex;
}

.app-header-title{
  position: fixed;
  top:20px;
  left:10px;
  right:10px;
  font-size: 30px;
  font-weight: 30px;
  font-family: "Hiragino Sans","ヒラギノ角ゴシック"; font-weight: 900;
  color: black;
  width:300px;
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
  font-size: 20px;
  font-weight: 30px;
  float: left;
  width:200px;
  /* float: left; */
}

.app-header-link-guest-login{
  font-size: 20px;
  position:fixed;
  top:40px;
  left:63%;
  color: black;
  cursor: pointer;
}
.app-header-link-guest-logout{
  font-size: 20px;
  position:fixed;
  top:40px;
  left:60%;
  color: black;
  cursor: pointer;
}

.app-header-link-register{
  position:fixed;
  top:40px;
  left:77%;
  color: black;
  text-decoration: none;
  cursor: pointer;
}
.app-header-link-login{
  /* margin-left:10px; */
  /* margin-right:10px; */
  /* margin-top:40px; */
  position:fixed;
  top:40px;
  left:90%;
  color: black;
  text-decoration: none;
  cursor: pointer;
  /* width:300px; */
}
.app-header-link-logout{
  /* margin-left:10px; */
  /* margin-right:10px; */
  position:fixed;
  top:40px;
  left:88%;
  color: black;
  cursor: pointer;
  /* width:300px; */
}
.user-icon{
  position:fixed;
  left:45%;
}
.user-name{
  font-size: 20px;
  position:fixed;
  left:44%;
  top:70px;
}
</style>
