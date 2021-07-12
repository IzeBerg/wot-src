package net.wg.infrastructure.managers.impl.tutorial
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   class ClickOutsideTriggerWatcher extends AbstractTriggerWatcher
   {
       
      
      function ClickOutsideTriggerWatcher(param1:String, param2:String)
      {
         super(param1,param2);
      }
      
      override public function start(param1:DisplayObject) : void
      {
         super.start(param1);
         App.stage.addEventListener(MouseEvent.CLICK,this.onStageClickHandler);
      }
      
      override public function stop() : void
      {
         App.stage.removeEventListener(MouseEvent.CLICK,this.onStageClickHandler);
         super.stop();
      }
      
      private function onStageClickHandler(param1:MouseEvent) : void
      {
         if(!target.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
         {
            dispatchTriggerEvent();
         }
      }
   }
}
