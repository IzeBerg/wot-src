package net.wg.infrastructure.managers.impl.tutorial
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import scaleform.clik.controls.Button;
   import scaleform.clik.events.ButtonEvent;
   
   class ClickTriggerWatcher extends AbstractTriggerWatcher
   {
       
      
      function ClickTriggerWatcher(param1:String, param2:String)
      {
         super(param1,param2);
      }
      
      override public function start(param1:DisplayObject) : void
      {
         super.start(param1);
         if(param1 is Button)
         {
            param1.addEventListener(ButtonEvent.CLICK,this.onTargetClickHandler,false,int.MAX_VALUE);
         }
         else
         {
            param1.addEventListener(MouseEvent.CLICK,this.onTargetClickHandler,false,int.MAX_VALUE);
         }
      }
      
      override public function stop() : void
      {
         if(target is Button)
         {
            target.removeEventListener(ButtonEvent.CLICK,this.onTargetClickHandler);
         }
         else
         {
            target.removeEventListener(MouseEvent.CLICK,this.onTargetClickHandler);
         }
         super.stop();
      }
      
      private function onTargetClickHandler(param1:Event) : void
      {
         dispatchTriggerEvent();
      }
   }
}
