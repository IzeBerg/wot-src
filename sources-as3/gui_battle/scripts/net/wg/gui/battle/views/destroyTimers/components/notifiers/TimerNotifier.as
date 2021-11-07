package net.wg.gui.battle.views.destroyTimers.components.notifiers
{
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class TimerNotifier extends BaseBarNotifier
   {
       
      
      public var timeTF:TextField;
      
      public function TimerNotifier()
      {
         super();
         stop();
         mouseEnabled = mouseChildren = false;
         TextFieldEx.setNoTranslate(this.timeTF,true);
      }
      
      override protected function onDispose() : void
      {
         this.timeTF = null;
         super.onDispose();
      }
      
      public function setData(param1:int, param2:int) : void
      {
         setBarRatio(param1 / param2);
      }
      
      protected function drawTime(param1:String) : void
      {
         this.timeTF.text = param1;
      }
   }
}
