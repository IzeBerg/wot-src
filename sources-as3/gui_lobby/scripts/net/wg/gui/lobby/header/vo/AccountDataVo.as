package net.wg.gui.lobby.header.vo
{
   import net.wg.data.VO.UserVO;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AccountDataVo extends DAAPIDataClass
   {
      
      private static const USER:String = "userVO";
       
      
      public var userVO:UserVO = null;
      
      public var isTeamKiller:Boolean = false;
      
      public var isWarningIconVisible:Boolean = false;
      
      public var isWotPlusEnabled:Boolean = false;
      
      public var tooltip:String = "";
      
      public var tooltipType:String = "";
      
      public var tooltipArgs:Array = null;
      
      public function AccountDataVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == USER)
         {
            this.userVO = new UserVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.userVO != null)
         {
            this.userVO.dispose();
            this.userVO = null;
         }
         if(this.tooltipArgs != null)
         {
            this.tooltipArgs.splice(0,this.tooltipArgs.length);
            this.tooltipArgs = null;
         }
         super.onDispose();
      }
   }
}
