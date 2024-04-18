package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.display.DisplayObject;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.hangar.ammunitionPanel.EquipmentSlot;
   import net.wg.gui.lobby.vehicleCompare.events.ClosableEquipmentSlotEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class ClosableEquipmentSlot extends UIComponentEx implements IPopOverCaller
   {
       
      
      public var slot:EquipmentSlot = null;
      
      public var removeBtn:ISoundButtonEx = null;
      
      public function ClosableEquipmentSlot()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.slot.removeEventListener(ButtonEvent.CLICK,this.onSlotClickHandler);
         this.slot.dispose();
         this.slot = null;
         this.removeBtn.removeEventListener(ButtonEvent.CLICK,this.onRemoveBtnClickHandler);
         this.removeBtn.dispose();
         this.removeBtn = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.slot.addEventListener(ButtonEvent.CLICK,this.onSlotClickHandler);
         this.removeBtn.addEventListener(ButtonEvent.CLICK,this.onRemoveBtnClickHandler);
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.slot;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.slot;
      }
      
      public function setData(param1:DeviceSlotVO) : void
      {
         this.slot.update(param1);
         this.removeBtn.visible = param1.showRemoveBtn;
      }
      
      public function get slotIndex() : Number
      {
         return this.slot.slotIndex;
      }
      
      public function set slotIndex(param1:Number) : void
      {
         this.slot.slotIndex = param1;
      }
      
      public function get type() : String
      {
         return this.slot.type;
      }
      
      public function set type(param1:String) : void
      {
         this.slot.type = param1;
      }
      
      private function onRemoveBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new ClosableEquipmentSlotEvent(ClosableEquipmentSlotEvent.REMOVE_CLICK,true));
      }
      
      private function onSlotClickHandler(param1:ButtonEvent) : void
      {
         if(this.slot.slotData && this.slot.slotData.slotLocked)
         {
            return;
         }
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new ClosableEquipmentSlotEvent(ClosableEquipmentSlotEvent.LEFT_BTN_CLICK));
         }
         else if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            dispatchEvent(new ClosableEquipmentSlotEvent(ClosableEquipmentSlotEvent.RIGHT_BTN_CLICK));
         }
      }
   }
}
