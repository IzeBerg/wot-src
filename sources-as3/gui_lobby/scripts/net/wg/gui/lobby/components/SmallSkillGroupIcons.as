package net.wg.gui.lobby.components
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SmallSkillGroupIcons extends UIComponentEx
   {
      
      private static const MULTIPLIER_SIGN:String = "x";
      
      private static const FRAME_SKILL:int = 1;
      
      private static const FRAME_NEW_SKILL:int = 2;
       
      
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
         this.skillsGroupNum.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function changeInnerFrame(param1:Boolean) : void
      {
         var _loc2_:int = !!param1 ? int(FRAME_NEW_SKILL) : int(FRAME_SKILL);
         this.gotoAndStop(_loc2_);
      }
   }
}
