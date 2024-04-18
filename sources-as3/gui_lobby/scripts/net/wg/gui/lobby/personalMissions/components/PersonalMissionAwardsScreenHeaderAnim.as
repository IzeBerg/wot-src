package net.wg.gui.lobby.personalMissions.components
{
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class PersonalMissionAwardsScreenHeaderAnim extends UIComponentEx
   {
      
      private static const FADE_IN_LABEL:String = "fadeIn";
      
      private static const FADE_OUT_LABEL:String = "fadeOut";
       
      
      public var header:AnimatedTextContainer = null;
      
      public var headerExtra:AnimatedTextContainer = null;
      
      public function PersonalMissionAwardsScreenHeaderAnim()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.header.textField.autoSize = TextFieldAutoSize.CENTER;
         this.headerExtra.textField.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.header.dispose();
         this.header = null;
         this.headerExtra.dispose();
         this.headerExtra = null;
         super.onDispose();
      }
      
      public function fadeIn() : void
      {
         gotoAndPlay(FADE_IN_LABEL);
      }
      
      public function fadeOut() : void
      {
         gotoAndPlay(FADE_OUT_LABEL);
      }
      
      public function setHeader(param1:String) : void
      {
         this.header.text = param1;
      }
      
      public function setHeaderExtra(param1:String) : void
      {
         this.headerExtra.text = param1;
      }
   }
}
