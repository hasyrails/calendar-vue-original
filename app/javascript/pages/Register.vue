<template>
<div class="register">
  <div class="row">
		<div class="col-md-8">
		  <h1 class="register-step">ユーザー登録  Step{{ stepNumber}}</h1>
      <keep-alive>

        <UserNameForm v-if="stepNumber===1" @update="updateForm"></UserNameForm>
        <EmailForm v-if="stepNumber===2" @update="updateForm"></EmailForm>
        <PasswordForm v-if="stepNumber===3" @update="updateForm"></PasswordForm>
        <ConfirmForm 
        :form="form" 
        v-if="stepNumber===4" 
        @update="updateForm" @clickedRegisterButton="register"></ConfirmForm >
      </keep-alive>
      <div class="register-step-button">
        <div class="register-step-prev-button" v-if="stepNumber != 1">
          <div class="register-step-next-button-label">戻る</div>
          <ArrowLeftThick class="btn btn-primary" @click="backStep"></ArrowLeftThick>
        </div>
        <div class="register-step-next-button" v-if="stepNumber != 4">
          <div class="register-step-next-button-label">次へ</div>
          <ArrowRightThick class="btn btn-primary" @click="nextStep"></ArrowRightThick>
        </div>
      </div>
    <!-- <pre><code>{{form}}</code></pre> -->
		</div>
	</div>
</div>
</template>

<script>
import UserNameForm from '../components/UserNameForm'
import EmailForm from '../components/EmailForm'
import PasswordForm from '../components/PasswordForm'
import ConfirmForm from '../components/ConfirmForm'

import ArrowRightThick from 'vue-material-design-icons/ArrowRightThick.vue'
import ArrowLeftThick from 'vue-material-design-icons/ArrowLeftThick.vue'

import axios from 'axios'

export default {
  name: 'Register',
  data(){
    return{
      stepNumber: 1,
			form: {
				name: null,
        email: null,
        password: null,
        password_confirmation: null
			}
    }
  },
  components: {
    UserNameForm,
    EmailForm,
    PasswordForm,
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
          this.$store.commit('user', response.data)
        })
      .catch(error => console.log(error.response));
    }
	}
}
</script>

<style scoped>
.register{
  /* background: #EEFFFF; */
  width: 100%;
  height: 100%;
  margin-right: 20%;
  margin-left: 20%;
  margin-top: 15%;
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
</style>
