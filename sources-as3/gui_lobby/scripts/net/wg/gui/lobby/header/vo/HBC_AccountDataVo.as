package net.wg.gui.lobby.header.vo
{
   import net.wg.data.VO.UserVO;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   
   public class HBC_AccountDataVo extends HBC_AbstractVO
   {
       
      
      public var userVO:UserVO = null;
      
      public var isTeamKiller:Boolean = false;
      
      public var isAnonymized:Boolean = false;
      
      public var isWarningIconVisible:Boolean = false;
      
      public var badgeVO:BadgeVisualVO = null;
      
      public var hasActiveBooster:Boolean = false;
      
      public var hasAvailableBoosters:Boolean = false;
      
      public var selectedBadge:Boolean = false;
      
      public var isWotPlusEnabled:Boolean = false;
      
      public var boosterIcon:String = "";
      
      public var boosterBg:String = "";
      
      public var boosterText:String = "";
      
      public function HBC_AccountDataVo(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.userVO != null)
         {
            this.userVO.dispose();
            this.userVO = null;
         }
         this.badgeVO = null;
         super.onDispose();
      }
   }
}
