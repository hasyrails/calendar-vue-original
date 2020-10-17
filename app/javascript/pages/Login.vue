<template>
<div class="login-page">
  <div class="register">
    <div class="row">
      <div class="col-md-8">
        <h1 class="register-step">ログイン</h1>
        <div style="margin-left:10%;">
          <UserRegisterMessage></UserRegisterMessage>
        </div>
        <keep-alive>
          <LoginForm @update="updateForm"></LoginForm>
        </keep-alive>
      </div>
    </div>
    <div class="btn btn-primary login-btn" @click="login">ログイン</div>
    <!-- <pre><code>{{form}}</code></pre> -->
  </div>
</div>
</template>

<script>
import axios from 'axios'

import LoginForm from '../components/LoginForm'

import ArrowRightThick from 'vue-material-design-icons/ArrowRightThick.vue'
import ArrowLeftThick from 'vue-material-design-icons/ArrowLeftThick.vue'

import UserRegisterMessage from '../components/UserRegisterMessage'

export default {
  name: 'Login',
  data(){
    return{
			form: {
        email: null,
        password: null,
        // password_confirmation: null,
			}
    }
  },
  components: {
    LoginForm,
    ArrowRightThick,
    ArrowLeftThick,
    UserRegisterMessage,
  },
  methods:{
		updateForm(formData){
			Object.assign(this.form, formData);
    },
    async login(){ 
      await axios.post('api/v1/auth/sign_in', this.form)
        .then(res => {
          this.$store.commit('auth', res.data)
          this.$router.push('/')
          this.$store.commit(`messages/setUserLoginSuccessMessage`,{
            userLoginSuccessMessage: 'ログインしました',
            timeout: 3000
          })
        })
      .catch(error => console.log(error.res));
    }
	}
}
</script>

<style scoped>
.login-page{
  width: 100vw;
  height: 100vh;
  background: #EEFFFF;
}

.register{
  /* margin-right: 10%;
  margin-left: 10%; */
  width: 100vw;
  position: fixed;
  top:20%;
  left:30%;
}

.register-step {
  text-align: left;
}

.login-btn {
  margin-left: 3%;
}
</style>
