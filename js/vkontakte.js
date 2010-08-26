function init(id)
{
    window.vkAsyncInit = function() {
        VK.init({
          apiId: id,
          nameTransportPath: '/xd_receiver.html'
        });
        VK.UI.button('vk_login');
      };
      (function() {
        var el = document.createElement("script");
        el.type = "text/javascript";
        el.charset = "windows-1251";
        el.src = "http://vkontakte.ru/js/api/openapi.js";
        el.async = true;
        document.getElementById("vk_api_transport").appendChild(el);
      }());
}


function doLogin() {
  VK.Auth.login(
    loginInternal,
    VK.access.FRIENDS | VK.access.WIKI
  );

}
function doLogout() {
  VK.Auth.logout(logoutOpenAPI);
}

function loginInternal(response)
{
    VK.Api.call('getVariable', {key: 1281}, function(r) {
        if(r.response) {
            window.location = '/login_vk?nickname=' + r.response;
        }
    });
}