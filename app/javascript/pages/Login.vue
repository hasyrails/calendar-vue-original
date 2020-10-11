<template>
<div class="register-page">
  <div class="row">
		<div class="col-md-8">
		  <h1 class="register-step">ログイン</h1>
      <keep-alive>
        <LoginForm @update="updateForm"></LoginForm>
      </keep-alive>
		</div>
	</div>
  <div class="btn btn-primary login-btn" @click="login">ログイン</div>
  <!-- <pre><code>{{form}}</code></pre> -->
</div>
</template>

<script>
import axios from 'axios'

import LoginForm from '../components/LoginForm'

import ArrowRightThick from 'vue-material-design-icons/ArrowRightThick.vue'
import ArrowLeftThick from 'vue-material-design-icons/ArrowLeftThick.vue'

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
    ArrowLeftThick
  },
  methods:{
		updateForm(formData){
			Object.assign(this.form, formData);
    },
    async login(){ 
      await axios.post('api/v1/auth/sign_in', this.form)
        .then(res => {
          this.$store.commit('auth', response.data)
        })
      .catch(error => console.log(error.response));
    }
	}
}
</script>

<style scoped>
.register-page{
  width: 80%;
  margin-right: 10%;
  margin-left: 10%;
  margin-top: 5%;
}

.register-step {
  text-align: left;
}

.login-btn {
  margin-left: 3%;
}
</style>
