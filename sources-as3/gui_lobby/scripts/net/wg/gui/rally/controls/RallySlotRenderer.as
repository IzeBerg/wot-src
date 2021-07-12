package net.wg.gui.rally.controls
{
   import net.wg.data.constants.UserTags;
   import net.wg.gui.components.controls.ButtonIconTextTransparent;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import scaleform.clik.events.ButtonEvent;
   
   public class RallySlotRenderer extends VoiceRallySlotRenderer
   {
       
      
      public var removeBtn:ButtonIconTextTransparent;
      
      public function RallySlotRenderer()
      {
         super();
      }
      
      override public function cooldown(param1:Boolean) : void
      {
         super.cooldown(param1);
         this.removeBtn.enabled = param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.removeBtn != null)
         {
            addTooltipSubscriber(this.removeBtn);
            this.removeBtn.addEventListener(ButtonEvent.CLICK,this.onRemoveClick);
         }
         if(commander != null)
         {
            addTooltipSubscriber(commander);
         }
         addTooltipSubscriber(statusIndicator);
         vehicleBtn.addEventListener(RallyViewsEvent.CHOOSE_VEHICLE,this.onChooseVehicleClick);
      }
      
      override protected function onDispose() : void
      {
         if(this.removeBtn != null)
         {
            removeTooltipSubscriber(this.removeBtn);
            this.removeBtn.removeEventListener(ButtonEvent.CLICK,this.onRemoveClick);
            this.removeBtn.dispose();
            this.removeBtn = null;
         }
         if(commander != null)
         {
            removeTooltipSubscriber(commander);
         }
         removeTooltipSubscriber(statusIndicator);
         vehicleBtn.removeEventListener(RallyViewsEvent.CHOOSE_VEHICLE,this.onChooseVehicleClick);
         super.onDispose();
      }
      
      protected function onRemoveClick(param1:ButtonEvent) : void
      {
         if(slotData && slotData.player)
         {
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LEAVE_SLOT_REQUEST,slotData.player.dbID));
         }
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
