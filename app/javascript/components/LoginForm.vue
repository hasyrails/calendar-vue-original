<template>
  <div class="form-container">
  <form @input="submit" class="register-form">
    <div class="form-group">
      <label for="Email">メールアドレス</label>
      <ValidationProvider rules="required">
        <div slot-scope="{ errors }">
          <input type="text" name="email" class="form-control form-control-lg" v-model="email" placeholder="Enter Email">
          <p class="error-message">{{ errors[0] }}</p>
        </div>
      </ValidationProvider>
    </div>
    <div class="form-group">
      <label for="Email">パスワード</label>
      <ValidationProvider rules="required">
        <div slot-scope="{ errors }">
          <input type="password" name="password" class="form-control form-control-lg" v-model="password" placeholder="Enter Password">
          <p class="error-message">{{ errors[0] }}</p>
        </div>
      </ValidationProvider>
    </div>
    <!-- <div class="form-group">
      <label for="Email">パスワード(確認)</label>
      <input type="text" class="form-control form-control-lg" v-model="password_confirmation" placeholder="Enter Password">
    </div> -->
  </form>
  </div>
</template>

<script>
import { ValidationProvider } from 'vee-validate';

export default {
  name: 'LoginForm',
  data(){
    return{
      email: null,
      password: null,
      // password_confirmation: null
    }
  },
  components:{
    ValidationProvider
  },
  methods: {
		submit(){
			this.$emit('update',{
				email: this.email,
        password: this.password,
        // password_confirmation: this.password_confirmation
			});
		}
	}
}
</script>

<style scoped>
  .form-container{
    /* width: 100%; */
    margin-left:3%;
    margin-right:3%;
    margin-top:3%;
  }

  .register-form{
    text-align: left;
  }

  .form-control{
    width: 50%;
  }

  .error-message{
    color: red;
    font-size:20px;
  }
</style>
