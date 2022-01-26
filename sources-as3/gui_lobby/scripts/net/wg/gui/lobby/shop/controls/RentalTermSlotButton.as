package net.wg.gui.lobby.shop.controls
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.SlotButtonBase;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.gui.lobby.shop.data.RentalTermSlotButtonVO;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class RentalTermSlotButton extends SlotButtonBase implements IUpdatable
   {
      
      public static const RENTAL_TERM_GROUP:String = "RentalTermGroup";
       
      
      public var labelTF:TextField;
      
      public var price:CompoundPrice;
      
      private var _slotData:RentalTermSlotButtonVO;
      
      public function RentalTermSlotButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         useFocusedAsSelect = false;
         toggle = true;
         allowDeselect = false;
         groupName = RENTAL_TERM_GROUP;
      }
      
      override protected function onDispose() : void
      {
         this._slotData = null;
         this.price.dispose();
         this.price = null;
         this.labelTF = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(this._slotData && isInvalid(InvalidationType.DATA))
         {
            this.price.setData(this._slotData.price);
            this.price.visible = this._slotData.enabled;
            this.price.updateEnoughStatuses(this._slotData.isEnoughStatuses);
            this.labelTF.htmlText = this._slotData.label;
            enabled = this._slotData.enabled;
            allowSelectionDispatch = false;
            selected = this._slotData.selected;
         }
         super.draw();
         allowSelectionDispatch = true;
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         super.handleClick(param1);
         invalidate(INV_SELECTION);
      }
      
      public function update(param1:Object) : void
      {
         this._slotData = RentalTermSlotButtonVO(param1);
         invalidateData();
      }
      
      public function get itemId() : int
      {
         return Boolean(this._slotData) ? int(this._slotData.itemId) : int(-1);
      }
   }
}
