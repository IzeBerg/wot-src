package net.wg.gui.messenger.data
{
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ContactItemVO extends DAAPIDataClass
   {
      
      public static const USER_PROPS:String = "userProps";
       
      
      public var dbID:Number = 0;
      
      public var note:String = "";
      
      public var resource:String = "";
      
      public var userProps:Object = null;
      
      private var _userPropsVO:ContactUserPropVO = null;
      
      public function ContactItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == USER_PROPS)
         {
            this._userPropsVO = new ContactUserPropVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      override protected function onDispose() : void
      {
         this._userPropsVO.dispose();
         this._userPropsVO = null;
         this.userProps = null;
         super.onDispose();
      }
      
      public function get userPropsVO() : ContactUserPropVO
      {
         return this._userPropsVO;
      }
      
      public function get userName() : String
      {
         return Boolean(this._userPropsVO) ? this._userPropsVO.userName : Values.EMPTY_STR;
      }
   }
}
