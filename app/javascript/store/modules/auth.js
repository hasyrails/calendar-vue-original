import axios from 'axios'


const auth = {
  namespaced: true,
  // state: {
  //   user: [],
  //   auth: {}
  // },
  // getters: {
  //   user: state => state.user,
  //   auth: state => state.auth
  // },
  // mutations: {
  //   user (state, value) {
  //     state.user = value
  //   },
  //   auth (state, value) {
  //     state.auth = value
  //   }
  // },
  // actions:{
  // },
  // getters: {
  // },
  state: {
    //ヘッダの入れ物を用意。
        headers: [],
        user: []
      },
    
      mutations: {
    
    //サインイン時のレスポンスヘッダから情報を抜き出して保存しておく。
        signIn(state, payload) {
          state.headers = {
            "access-token": payload["access-token"],
            "client": payload["client"],
            "uid": payload["uid"],
          }
        },
        userInfo(state, payload) {
          state.user = {
            "user": payload
          }
        },

    
    //サインアウトしたらヘッダを空にしておく。
        signOut(state) {
          state.headers = null;
        },
      },
    
      actions: {
    //paramsはemailなどのユーザー情報が入っていると思って下さい。
    //（paramsへの情報の入れ方は今回割愛。）
        signIn({commit}, params) {
          axios
            .post('/api/v1/auth/sign_in', params)
            .then(function (response) {
              //ここでレスポンスヘッダを受け取る。
              commit('signIn', response.headers);
              commit('userInfo', response.data);
            })
          },
          userInfo({state, commit}){
            axios
              .get('/api/whoami', {
                headers: {
                  header: state.header
                }
              })
              .then(function (response) {
                commit('userInfo', response.data);
              }
            )
          },
        //ここでレスポンスヘッダを受け取る。
          signOut(context) {
          axios
    //ここでヘッダ情報を呼び出してDELETEリクエストに含める
            .delete('/api/v1/auth/sign_out', { headers: context.state.headers })
            .then(function () {
              context.commit('signOut');
          })
        },
      },
}

export default auth;
