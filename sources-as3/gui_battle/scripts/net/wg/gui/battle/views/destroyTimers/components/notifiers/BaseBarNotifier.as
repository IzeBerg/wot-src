package net.wg.gui.battle.views.destroyTimers.components.notifiers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import scaleform.gfx.TextFieldEx;
   
   public class BaseBarNotifier extends MovieClip implements INotifier
   {
       
      
      public var messageTF:TextField;
      
      public function BaseBarNotifier()
      {
         super();
         stop();
         mouseChildren = mouseEnabled = false;
         if(this.messageTF != null)
         {
            TextFieldEx.setNoTranslate(this.messageTF,true);
         }
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this.messageTF = null;
      }
      
      public function setText(param1:String) : void
      {
         if(this.messageTF != null)
         {
            this.messageTF.autoSize = TextFieldAutoSize.CENTER;
            this.messageTF.htmlText = param1;
         }
      }
      
      protected function setBarRatio(param1:Number) : void
      {
         var _loc2_:int = 1 + int((totalFrames - 1) * param1);
         if(currentFrame != _loc2_)
         {
            gotoAndStop(_loc2_);
         }
      }
      
      protected function onDispose() : void
      {
      }
   }
}
