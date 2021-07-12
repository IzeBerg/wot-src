package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.window.ProfileWindowInitVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ProfileWindowMeta extends AbstractWindowView
   {
       
      
      public var userAddFriend:Function;
      
      public var userAddToClan:Function;
      
      public var userSetIgnored:Function;
      
      public var userCreatePrivateChannel:Function;
      
      private var _profileWindowInitVO:ProfileWindowInitVO;
      
      public function ProfileWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._profileWindowInitVO)
         {
            this._profileWindowInitVO.dispose();
            this._profileWindowInitVO = null;
         }
         super.onDispose();
      }
      
      public function userAddFriendS() : void
      {
         App.utils.asserter.assertNotNull(this.userAddFriend,"userAddFriend" + Errors.CANT_NULL);
         this.userAddFriend();
      }
      
      public function userAddToClanS() : void
      {
         App.utils.asserter.assertNotNull(this.userAddToClan,"userAddToClan" + Errors.CANT_NULL);
         this.userAddToClan();
      }
      
      public function userSetIgnoredS() : void
      {
         App.utils.asserter.assertNotNull(this.userSetIgnored,"userSetIgnored" + Errors.CANT_NULL);
         this.userSetIgnored();
      }
      
      public function userCreatePrivateChannelS() : void
      {
         App.utils.asserter.assertNotNull(this.userCreatePrivateChannel,"userCreatePrivateChannel" + Errors.CANT_NULL);
         this.userCreatePrivateChannel();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:ProfileWindowInitVO = this._profileWindowInitVO;
         this._profileWindowInitVO = new ProfileWindowInitVO(param1);
         this.setInitData(this._profileWindowInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:ProfileWindowInitVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
