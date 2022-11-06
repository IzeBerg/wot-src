package net.wg.infrastructure.managers.impl.tutorial
{
   import flash.display.DisplayObject;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.InputEvent;
   
   class EscapeTriggerWatcher extends AbstractTriggerWatcher
   {
       
      
      function EscapeTriggerWatcher(param1:String, param2:String)
      {
         super(param1,param2);
      }
      
      override public function start(param1:DisplayObject) : void
      {
         super.start(param1);
         App.stage.addEventListener(InputEvent.INPUT,this.onInputHandler);
      }
      
      override public function stop() : void
      {
         App.stage.removeEventListener(InputEvent.INPUT,this.onInputHandler);
         super.stop();
      }
      
      private function onInputHandler(param1:InputEvent) : void
      {
         if(param1.details.value == InputValue.KEY_DOWN && param1.details.code == Keyboard.ESCAPE)
         {
            dispatchTriggerEvent();
         }
      }
   }
}
