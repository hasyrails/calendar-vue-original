<template>
  <div class="row">
		<div class="col-md-8">
		<h1>Step:{{ stepNumber}}</h1>
		</div>
	</div>
</template>

<script>
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
  }
}
</script>

<style scoped>

</style>
