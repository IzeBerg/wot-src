package net.wg.gui.lobby.components
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SmallSkillGroupIcons extends UIComponentEx
   {
      
      private static const MULTIPLIER_SIGN:String = "x";
       
      
      public var skillsGroupNum:TextField = null;
      
      public function SmallSkillGroupIcons()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.skillsGroupNum = null;
         super.onDispose();
      }
      
      public function setSkillsNumber(param1:int) : void
      {
         this.skillsGroupNum.text = MULTIPLIER_SIGN + param1;
      }
   }
}
