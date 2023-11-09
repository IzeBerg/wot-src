package net.wg.gui.cyberSport.views.respawn
{
   import flash.text.TextField;
   import net.wg.data.constants.UserTags;
   import net.wg.gui.rally.controls.VoiceRallySlotRenderer;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   
   public class RespawnTeamSlot extends VoiceRallySlotRenderer
   {
       
      
      public var levelLbl:TextField = null;
      
      private var _isHimSelf:Boolean = false;
      
      public function RespawnTeamSlot()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         vehicleBtn.addEventListener(RallyViewsEvent.CHOOSE_VEHICLE,this.onChooseVehicleClick);
      }
      
      override protected function onDispose() : void
      {
         vehicleBtn.removeEventListener(RallyViewsEvent.CHOOSE_VEHICLE,this.onChooseVehicleClick);
         super.onDispose();
         this.levelLbl = null;
      }
      
      override public function set slotData(param1:IRallySlotVO) : void
      {
         super.slotData = param1;
         this.isHimSelf = Boolean(param1.player) ? Boolean(UserTags.isCurrentPlayer(param1.player.tags)) : Boolean(false);
      }
      
      public function get isHimSelf() : Boolean
      {
         return this._isHimSelf;
      }
      
      public function set isHimSelf(param1:Boolean) : void
      {
         this._isHimSelf = param1;
      }
      
      protected function onChooseVehicleClick(param1:RallyViewsEvent) : void
      {
         param1.preventDefault();
         param1.stopImmediatePropagation();
         if(slotData && slotData.player && UserTags.isCurrentPlayer(slotData.player.tags))
         {
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.CHOOSE_VEHICLE,slotData.player.dbID));
         }
      }
   }
}
