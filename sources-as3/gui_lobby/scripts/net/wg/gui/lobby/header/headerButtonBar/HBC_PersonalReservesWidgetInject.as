package net.wg.gui.lobby.header.headerButtonBar
{
   import net.wg.gui.lobby.header.events.PersonalReservesWidgetEvent;
   import net.wg.infrastructure.base.meta.IPersonalReservesWidgetInjectMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalReservesWidgetInjectMeta;
   
   public class HBC_PersonalReservesWidgetInject extends PersonalReservesWidgetInjectMeta implements IPersonalReservesWidgetInjectMeta
   {
       
      
      private var _targetWidth:Number = 0;
      
      public function HBC_PersonalReservesWidgetInject()
      {
         super();
         setManageSize(true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         dispatchEvent(new PersonalReservesWidgetEvent(PersonalReservesWidgetEvent.CREATED,true));
      }
      
      public function as_setTargetWidth(param1:Number) : void
      {
         this._targetWidth = param1;
         dispatchEvent(new PersonalReservesWidgetEvent(PersonalReservesWidgetEvent.RESIZED,true));
      }
      
      public function get targetWidth() : Number
      {
         return this._targetWidth;
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
   }
}
