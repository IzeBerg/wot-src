package net.wg.gui.lobby.header.headerButtonBar
{
   import net.wg.data.constants.Directions;
   import net.wg.gui.lobby.header.events.PersonalReservesWidgetEvent;
   import net.wg.infrastructure.base.meta.IPersonalReservesWidgetInjectMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalReservesWidgetInjectMeta;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   
   public class HBC_PersonalReservesWidgetInject extends PersonalReservesWidgetInjectMeta implements IPersonalReservesWidgetInjectMeta, IHelpLayoutComponent
   {
      
      private static const HELP_LAYOUT_ID_DELIMITER:String = "_";
       
      
      private var _helpLayoutId:String = "";
      
      private var _targetWidth:Number = 0;
      
      public function HBC_PersonalReservesWidgetInject()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         dispatchEvent(new PersonalReservesWidgetEvent(PersonalReservesWidgetEvent.CREATED,true));
         App.utils.helpLayout.registerComponent(this);
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
         App.utils.helpLayout.unregisterComponent(this);
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         if(!this._helpLayoutId)
         {
            this._helpLayoutId = name + HELP_LAYOUT_ID_DELIMITER + Math.random();
         }
         var _loc1_:HelpLayoutVO = new HelpLayoutVO();
         _loc1_.x = 0;
         _loc1_.y = 1;
         _loc1_.width = actualWidth;
         _loc1_.height = actualHeight - 2;
         _loc1_.extensibilityDirection = Directions.BOTTOM;
         _loc1_.message = LOBBY_HELP.HEADER_PERSONAL_RESERVES;
         _loc1_.id = this._helpLayoutId;
         _loc1_.scope = this;
         return new <HelpLayoutVO>[_loc1_];
      }
   }
}
