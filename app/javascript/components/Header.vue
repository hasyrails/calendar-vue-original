<template>
<div>
  <div class="app-header" v-if="this.$route.path!=='/schedules'">
    <div class="app-header-contents">
      <router-link to="/">
        <div class="app-header-title">初志しか勝たん<BoxingGlove :size="30"></BoxingGlove>
        </div>
        <!-- <p class="app-header-title-footer">初志貫徹アプリ</p> -->
        <!-- <pre><code>{{$store.getters['auth/user']}}</code></pre> -->
      </router-link>
      
      <div>
        <div class="user-icon user-image" v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0&&src">
          <router-link to="/userinfo"> 
            <img style="border-radius:50%;" :src="src" width="70" height="70">
          </router-link>
        </div>
        <div class="user-icon" v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0&&!src">
          <router-link to="/userinfo"> 
            <Account :size="70"></Account>
          </router-link>
        </div>
        <div class="user-icon" v-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length!==0">
          <router-link to="/userinfo"> 
            <Account :size="70"></Account>
          </router-link>
        </div>
      </div>

      <div>
        <div class="user-name" v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0">
          {{ $store.state.auth.user.name }}さん
        </div>
        <div class="user-name" v-else-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length===0">
          {{ $store.state.auth.user.name }}さん
        </div>
        <div class="user-name" v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length!==0">
          {{ $store.state.auth.user.name }}さん
        </div>
        <div class="user-name" v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length===0">
          <!-- {{ this.$store.state.auth.user.name }}さん -->
        </div>
      </div>
      
      <div>
        <div class="app-header-link-guest-login" 
        v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0"
        @click="guestLogin"> 
          <!-- ゲストログイン -->
        </div>
        <div class="app-header-link-guest-login"
        v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length===0"
        @click="guestLogin"> 
          ゲストログイン
        </div>
        <div v-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length!==0">
          <!-- <div class="app-header-link-guest-login" @click="guestLogin"> 
            ゲストログイン
          </div> -->
        </div>
        <div class="app-header-link-guest-login"
        v-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length===0"
        @click="guestLogin"> 
          ゲストログイン
        </div>
      </div>

    <div class="app-header-link">
      <div v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0">
        <div class="app-header-link-guest-logout" @click="guestLogOut">
          <!-- ログアウト（ゲスト） -->
        </div>
      </div>
      <div v-else-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length===0">
        <div class="app-header-link-guest-logout" @click="guestLogOut">
          <!-- ログアウト（ゲスト） -->
        </div>
      </div>
      <div v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length!==0">
        <div class="app-header-link-guest-logout" @click="guestLogOut">
          ログアウト（ゲスト）
        </div>
      </div>
      <div v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length===0">
        <div class="app-header-link-guest-logout" @click="guestLogOut">
          <!-- ログアウト（ゲスト） -->
        </div>
      </div>
    </div>

    <div class="app-header-link">
      <div class="app-header-link-register" v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0">
      </div>
      <div class="app-header-link-register" v-else-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length===0">
        <router-link to="/register">
          ユーザー登録
        </router-link>
      </div>
      <div class="app-header-link-register" v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length!==0">
        <router-link to="/register">
          ユーザー登録
        </router-link>
      </div>
      <div class="app-header-link-register" v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length===0">
        <router-link to="/register">
          ユーザー登録
        </router-link>
      </div>
    </div>

      <div class="app-header-link">
        <div class="app-header-link-login" v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0">
          <!-- <router-link to="/login">
            <div>ログイン</div>
          </router-link> -->
        </div>
        <div class="app-header-link-login" v-else-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length===0">
          <router-link to="/login">
            <div>ログイン</div>
          </router-link>
        </div>
        <div class="app-header-link-login" v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length!==0">
          <router-link to="/login">
            <div>ログイン</div>
          </router-link>
        </div>
        <div class="app-header-link-login" v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length===0">
          <router-link to="/login">
            <div>ログイン</div>
          </router-link>
        </div>
      </div>

    <div class="app-header-link">
      <div class="app-header-link-logout" v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0">
        <div @click="logout">
          ログアウト
        </div>
      </div>
      <div class="app-header-link-logout" v-else-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length===0">
        <!-- <div @click="logout">
          ログアウト
        </div> -->
      </div>
      <div class="app-header-link-logout" v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length!==0">
        <!-- <div @click="logout">
          ログアウト
        </div> -->
      </div>
      <div class="app-header-link-logout" v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length===0">
    </div>
    </div>
    </div>
  </div>

  <div class="app-header" v-if="this.$route.path==='/schedules'" style="width:650%;">
    <div class="app-header-contents">
      <router-link to="/">
        <div class="app-header-title">初志しか勝たん<BoxingGlove :size="30"></BoxingGlove>
        </div>
        <!-- <p class="app-header-title-footer">初志貫徹アプリ</p> -->
      </router-link>
      
      <div>
        <div class="user-icon" v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0&&src">
          <router-link to="/userinfo"> 
            <img style="border-radius:50%;" :src="src" width="70" height="70">
          </router-link>
        </div>
        <div class="user-icon" v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0&&!src">
          <router-link to="/userinfo"> 
            <Account :size="70"></Account>
          </router-link>
        </div>
        <div class="user-icon" v-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length!==0">
          <router-link to="/userinfo"> 
            <Account :size="70"></Account>
          </router-link>
        </div>
      </div>

      <div>
        <div class="user-name" v-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length!==0">
          {{ $store.state.auth.user.name }}さん
        </div>
        <div class="user-name" v-else-if="$store.state.auth.headers.length!==0&&$store.state.auth.user.length===0">
          {{ $store.state.auth.user.name }}さん
        </div>
        <div class="user-name" v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length!==0">
          {{ $store.state.auth.user.name }}さん
        </div>
        <div class="user-name" v-else-if="$store.state.auth.headers.length===0&&$store.state.auth.user.length===0">
          <!-- {{ this.$store.state.auth.user.name }}さん -->
        </div>
      </div>
      
      <div>
        <div class="app-header-link-guest-login" 
        v-if="this.$store.state.auth.headers.length!==0&&this.$store.state.auth.user.length!==0"
        @click="guestLogin"> 
          <!-- ゲストログイン -->
        </div>
        <div class="app-header-link-guest-login"
        v-if="this.$store.state.auth.headers.length!==0&&this.$store.state.auth.user.length===0"
        @click="guestLogin"> 
          ゲストログイン
        </div>
        <div v-if="this.$store.state.auth.headers.length===0&&this.$store.state.auth.user.length!==0">
          <!-- <div class="app-header-link-guest-login" @click="guestLogin"> 
            ゲストログイン
          </div> -->
        </div>
        <div class="app-header-link-guest-login"
        v-if="this.$store.state.auth.headers.length===0&&this.$store.state.auth.user.length===0"
        @click="guestLogin"> 
          ゲストログイン
        </div>
      </div>

    <div class="app-header-link">
      <div v-if="this.$store.state.auth.headers.length!==0&&this.$store.state.auth.user.length!==0">
        <div class="app-header-link-guest-logout" @click="guestLogOut">
          <!-- ログアウト（ゲスト） -->
        </div>
      </div>
      <div v-else-if="this.$store.state.auth.headers.length!==0&&this.$store.state.auth.user.length===0">
        <div class="app-header-link-guest-logout" @click="guestLogOut">
          <!-- ログアウト（ゲスト） -->
        </div>
      </div>
      <div v-else-if="this.$store.state.auth.headers.length===0&&this.$store.state.auth.user.length!==0">
        <div class="app-header-link-guest-logout" @click="guestLogOut">
          ログアウト（ゲスト）
        </div>
      </div>
      <div v-else-if="this.$store.state.auth.headers.length===0&&this.$store.state.auth.user.length===0">
        <div class="app-header-link-guest-logout" @click="guestLogOut">
          <!-- ログアウト（ゲスト） -->
        </div>
      </div>
    </div>

    <div class="app-header-link">
      <div class="app-header-link-register" v-if="this.$store.state.auth.headers.length!==0&&this.$store.state.auth.user.length!==0">
      </div>
      <div class="app-header-link-register" v-else-if="this.$store.state.auth.headers.length!==0&&this.$store.state.auth.user.length===0">
        <router-link to="/register">
          ユーザー登録
        </router-link>
      </div>
      <div class="app-header-link-register" v-else-if="this.$store.state.auth.headers.length===0&&this.$store.state.auth.user.length!==0">
        <router-link to="/register">
          ユーザー登録
        </router-link>
      </div>
      <div class="app-header-link-register" v-else-if="this.$store.state.auth.headers.length===0&&this.$store.state.auth.user.length===0">
        <router-link to="/register">
          ユーザー登録
        </router-link>
      </div>
    </div>

      <div class="app-header-link">
        <div class="app-header-link-login" v-if="this.$store.state.auth.headers.length!==0&&this.$store.state.auth.user.length!==0">
          <!-- <router-link to="/login">
            <div>ログイン</div>
          </router-link> -->
        </div>
        <div class="app-header-link-login" v-else-if="this.$store.state.auth.headers.length!==0&&this.$store.state.auth.user.length===0">
          <router-link to="/login">
            <div>ログイン</div>
          </router-link>
        </div>
        <div class="app-header-link-login" v-else-if="this.$store.state.auth.headers.length===0&&this.$store.state.auth.user.length!==0">
          <router-link to="/login">
            <div>ログイン</div>
          </router-link>
        </div>
        <div class="app-header-link-login" v-else-if="this.$store.state.auth.headers.length===0&&this.$store.state.auth.user.length===0">
          <router-link to="/login">
            <div>ログイン</div>
          </router-link>
        </div>
      </div>

    <div class="app-header-link">
      <div class="app-header-link-logout" v-if="this.$store.state.auth.headers.length!==0&&this.$store.state.auth.user.length!==0">
        <div @click="logout">
          ログアウト
        </div>
      </div>
      <div class="app-header-link-logout" v-else-if="this.$store.state.auth.headers.length!==0&&this.$store.state.auth.user.length===0">
        <!-- <div @click="logout">
          ログアウト
        </div> -->
      </div>
      <div class="app-header-link-logout" v-else-if="this.$store.state.auth.headers.length===0&&this.$store.state.auth.user.length!==0">
        <!-- <div @click="logout">
          ログアウト
        </div> -->
      </div>
      <div class="app-header-link-logout" v-else-if="this.$store.state.auth.headers.length===0&&this.$store.state.auth.user.length===0">
    </div>
    </div>
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
        src: this.$store.getters['auth/user'].image,
      }
    },
    components:{
      BoxingGlove,
      Account,
    },
    computed:{
      appHeaderStyle(){
      const appHeaderStyle = []
      if(this.path==="/schedules"){
        appHeaderStyle.push['width:400%;']
      }
      return appHeaderStyle
      },
      path(){
        return this.$route.path
      }
    },
    methods:{
      logout(){
        if(confirm('ログアウトしますか？')){
          this.$store.dispatch('auth/signOut')
          this.$store.dispatch('auth/guestLogOutAction')
          this.$router.push('/')
        }
      },
      guestLogin(){
        this.$store.dispatch('auth/guestLoginAction')
      },
      guestLogOut(){
        this.$store.dispatch('auth/guestLogOutAction')
        this.$router.push('/')
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
  position: fixed;
  top: 0px;
  background: hsl(180, 65%, 81%);
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
  top:30px;
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
