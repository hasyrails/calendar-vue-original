<template>
  <div class="row">
		<div class="col-md-8">
		  <h1>Step:{{ stepNumber}}</h1>
      <keep-alive>

        <UserNameForm v-if="stepNumber===1" @update="updateForm"></UserNameForm>
        <EmailForm v-if="stepNumber===2" @update="updateForm"></EmailForm>
        <PasswordForm v-if="stepNumber===3" @update="updateForm"></PasswordForm>
        <ConfirmForm :form="form" v-if="stepNumber===4" @update="updateForm"></ConfirmForm>
      </keep-alive>
      <button class="btn btn-primary" @click="backStep" v-show="stepNumber != 1">Back</button>
      <button class="btn btn-primary" @click="nextStep" v-show="stepNumber != 4">Next</button>
		</div>
    <pre><code>{{form}}</code></pre>
	</div>
</template>

<script>
import UserNameForm from '../components/UserNameForm'
import EmailForm from '../components/EmailForm'
import PasswordForm from '../components/PasswordForm'
import ConfirmForm from '../components/ConfirmForm'

export default {
  name: 'Register',
  data(){
    return{
      stepNumber: 1,
			form: {
				userName: null,
        email: null,
        password: null,
        passwordConfirmation: null
			}
    }
  },
  components: {
    UserNameForm,
    EmailForm,
    PasswordForm,
    ConfirmForm
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
	}
}
</script>

<style scoped>

</style>
