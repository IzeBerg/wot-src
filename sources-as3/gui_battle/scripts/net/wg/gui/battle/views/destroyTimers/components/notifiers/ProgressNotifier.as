package net.wg.gui.battle.views.destroyTimers.components.notifiers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class ProgressNotifier extends BaseBarNotifier
   {
      
      private static const SEPARATOR:String = " / ";
      
      public static const NON_ACTIVE_ICON:int = 1;
      
      public static const ACTIVE_ICON:int = 2;
       
      
      public var progressTF:TextField;
      
      public var icon:MovieClip;
      
      public function ProgressNotifier()
      {
         super();
         this.icon.stop();
         if(this.progressTF != null)
         {
            TextFieldEx.setNoTranslate(this.progressTF,true);
         }
      }
      
      override protected function onDispose() : void
      {
         this.progressTF = null;
         this.icon = null;
         super.onDispose();
      }
      
      public function setProgress(param1:int, param2:int, param3:Boolean) : void
      {
         param2 = Math.max(1,param2);
         setBarRatio(param1 / param2);
         var _loc4_:int = !!param3 ? int(ACTIVE_ICON) : int(NON_ACTIVE_ICON);
         if(this.icon.currentFrame != _loc4_)
         {
            this.icon.gotoAndStop(_loc4_);
         }
         if(this.progressTF != null)
         {
            this.progressTF.text = param1 + SEPARATOR + param2;
         }
      }
   }
}
