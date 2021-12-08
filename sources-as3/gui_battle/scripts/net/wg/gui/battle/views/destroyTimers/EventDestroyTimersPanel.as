package net.wg.gui.battle.views.destroyTimers
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.base.meta.IEventDestroyTimersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.EventDestroyTimersPanelMeta;
   
   public class EventDestroyTimersPanel extends EventDestroyTimersPanelMeta implements IEventDestroyTimersPanelMeta
   {
      
      protected static const INVALID_WARNING:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
       
      
      public var warningTF:TextField = null;
      
      private var _visible:Boolean = false;
      
      private var _txt:String = "";
      
      public function EventDestroyTimersPanel()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_WARNING))
         {
            if(this.warningTF)
            {
               this.warningTF.visible = this._visible;
               this.warningTF.text = this._txt;
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.warningTF)
         {
            this.warningTF.visible = false;
         }
      }
      
      override protected function onDispose() : void
      {
         this.warningTF = null;
         super.onDispose();
      }
      
      public function as_setWarningText(param1:String, param2:Boolean) : void
      {
         this._visible = param2;
         this._txt = param1;
         invalidate(INVALID_WARNING);
      }
   }
}
