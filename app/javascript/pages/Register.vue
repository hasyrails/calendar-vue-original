<template>
<div class="register">
  <div class="row">
		<div class="col-md-8">
		  <h1 class="register-step">ユーザー登録  Step{{ stepNumber}}</h1>
      <keep-alive>
        <UserNameForm v-if="stepNumber===1" @update="updateForm"></UserNameForm>
        <EmailForm v-if="stepNumber===2" @update="updateForm"></EmailForm>
        <UserIconForm v-if="stepNumber===3" @update="updateForm"></UserIconForm>
        <PasswordForm v-if="stepNumber===4" @update="updateForm"></PasswordForm>
        <ConfirmForm 
        :form="form" 
        v-if="stepNumber===5" 
        @update="updateForm" @clickedRegisterButton="register"></ConfirmForm >
      </keep-alive>
      <div class="register-step-button">
        <div class="register-step-prev-button" v-if="stepNumber != 1">
          <div class="register-step-next-button-label">戻る</div>
          <ArrowLeftThick class="btn btn-primary" @click="backStep"></ArrowLeftThick>
        </div>
        <div class="register-step-next-button" v-if="stepNumber != 5">
          <div class="register-step-next-button-label">次へ</div>
          <ArrowRightThick class="btn btn-primary" @click="nextStep"></ArrowRightThick>
        </div>
      </div>
    <!-- <pre><code>{{form}}</code></pre> -->
		</div>
	</div>
  <div class="error-message">{{message}}</div>
</div>
</template>

<script>
import UserNameForm from '../components/UserNameForm'
import EmailForm from '../components/EmailForm'
import PasswordForm from '../components/PasswordForm'
import ConfirmForm from '../components/ConfirmForm'
import UserIconForm from '../components/UserIconForm'

import ArrowRightThick from 'vue-material-design-icons/ArrowRightThick.vue'
import ArrowLeftThick from 'vue-material-design-icons/ArrowLeftThick.vue'

import axios from 'axios'

export default {
  name: 'Register',
  data(){
    return{
      stepNumber: 1,
			form: {
				name: '',
        email: '',
        image: '',
        password: '',
        password_confirmation: '',
      },
      message: ''
    }
  },
  components: {
    UserNameForm,
    EmailForm,
    PasswordForm,
    UserIconForm,
    ConfirmForm,
    ArrowRightThick,
    ArrowLeftThick
  },
  methods:{
		updateForm(formData){
			Object.assign(this.form, formData);
    },
    backStep:function(){
		  this.stepNumber--;
	  },			
	  nextStep:function(){
		  this.stepNumber++;
    },
    async register(){ 
      await axios.post('api/v1/auth', this.form)
        .then(res => {
          this.$store.commit('user', res.data)
          this.$store.commit(`messages/setUserRegisterSuccessMessage`,{
            userRegisterSuccessMessage: 'ユーザー登録に成功しました',
            timeout: 6000
          })
          this.$router.push('login')
        })
      .catch(
        error =>{
          console.log(error)
          if(error){
            this.message = 'ユーザー登録に失敗しました'
            setTimeout(() => {
              this.message = ''
            }
            ,1500
            )
          }
        } 
      );
    }
	}
}
</script>

<style scoped>
.register{
  /* background: #EEFFFF; */
  width: 100vw;
  height: 100vh;
  background: #EEFFFF;
  /* width: 100%;
  height: 100%; */
}

.row{
  width: 100vw;
  position: fixed;
  top:23%;
  left:30%;
}

.register-step {
  text-align: left;
}

.register-step-button {
  display: flex;
  margin-left: 3%;
}

.register-step-prev-button {
  margin-left: 1%;
  margin-top: 1%;
}
.register-step-next-button {
  margin-left: 40%;
  margin-top: 1%;
}
.register-step-next-button-label {
  text-align: center;
}

.error-message{
  color:red;
  font-size:20px;
  position: fixed;
  top:40%;
  left:61%;
}
</style>
