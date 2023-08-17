package net.wg.gui.lobby.epicBattles.components.afterBattle
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.components.IconTextWrapper;
   
   public class EpicBattlesAnimatedTitleTextfield extends MovieClip
   {
      
      public static const LEVEL_UP_ANIM_FRAME_LBL:String = "levelup";
       
      
      public var titleText:IconTextWrapper = null;
      
      public function EpicBattlesAnimatedTitleTextfield()
      {
         super();
         mouseChildren = mouseEnabled = false;
      }
      
      public final function dispose() : void
      {
         stop();
         this.titleText.dispose();
         this.titleText = null;
      }
      
      public function getWidth() : int
      {
         return this.titleText.textField.width;
      }
      
      public function setText(param1:String) : void
      {
         this.titleText.setHtmlText(param1);
         this.titleText.validateNow();
      }
   }
}
