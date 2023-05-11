package net.wg.gui.lobby.tankman
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.controls.StatusIndicator;
   
   public class PersonalCaseUsingLevel extends UIComponentEx
   {
      
      private static const MAX_SPECIALIZATION_LEVEL:uint = 100;
       
      
      public var usingLevel:TextField;
      
      public var levelValue:TextField;
      
      public var usingLevelLoadingBar:StatusIndicator;
      
      public function PersonalCaseUsingLevel()
      {
         super();
         this.usingLevel.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this.usingLevel = null;
         this.levelValue = null;
         this.usingLevelLoadingBar.dispose();
         this.usingLevelLoadingBar = null;
         super.onDispose();
      }
      
      public function setData(param1:Number) : void
      {
         this.levelValue.text = param1.toString() + "%";
         this.usingLevelLoadingBar.maximum = MAX_SPECIALIZATION_LEVEL;
         this.usingLevelLoadingBar.minimum = 0;
         this.usingLevelLoadingBar.position = param1;
      }
   }
}
