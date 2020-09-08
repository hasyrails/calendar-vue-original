<template>
  <div class="row">
		<div class="col-md-8">
		<h1>Step:{{ stepNumber}}</h1>
      <UserNameForm v-if="stepNumber===1" @update="updateForm"></UserNameForm>
		</div>
    <pre><code>{{form}}</code></pre>
	</div>
</template>

<script>
import UserNameForm from '../components/UserNameForm'

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
    UserNameForm
  },
  methods:{
		updateForm(formData){
			Object.assign(this.form, formData);
		},
	}
}
</script>

<style scoped>

</style>
