package net.wg.gui.lobby.clans.invites.VOs
{
   import net.wg.data.VO.UserVO;
   
   public class UserInvitesWindowItemVO extends ClanInvitesWindowAbstractItemVO
   {
      
      private static const USER_INFO:String = "userInfo";
       
      
      private var _userInfo:UserVO = null;
      
      public function UserInvitesWindowItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(USER_INFO == param1)
         {
            this._userInfo = new UserVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._userInfo.dispose();
         this._userInfo = null;
         super.onDispose();
      }
      
      public function get userInfo() : UserVO
      {
         return this._userInfo;
      }
   }
}
