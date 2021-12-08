package net.wg.gui.lobby.modulesPanel.components
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.AmmunitionButton;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.modulesPanel.interfaces.IDeviceSlot;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   
   [Event(name="deviceChange",type="net.wg.gui.events.DeviceEvent")]
   public class DeviceSlot extends AmmunitionButton implements IDeviceSlot
   {
       
      
      private var _slotData:DeviceSlotVO = null;
      
      private var _type:String = null;
      
      private var _slotIndex:Number = 0;
      
      private var _tooltip:String = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _counterManager:ICounterManager;
      
      private var _haveCounter:Boolean = false;
      
      public function DeviceSlot()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._counterManager = App.utils.counterManager;
         _deferredDispose = true;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabledOnDisabled = true;
         mouseChildren = false;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         this._toolTipMgr = null;
         this._slotData = null;
         this._counterManager = null;
         super.onDispose();
      }
      
      override protected function onBeforeDispose() : void
      {
         if(this._haveCounter)
         {
            this._counterManager.removeCounter(this);
         }
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._slotData != null)
         {
            this.tryAddCounter();
         }
      }
      
      public function getHitArea() : DisplayObject
      {
         return this;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this;
      }
      
      public function update(param1:Object) : void
      {
         this._slotData = DeviceSlotVO(param1);
         invalidate(InvalidationType.DATA);
      }
      
      protected function isEmpty() : Boolean
      {
         return isNaN(this._slotData.id);
      }
      
      private function tryAddCounter() : void
      {
         if(this._slotData.counter > 0)
         {
            this._counterManager.setCounter(this,this._slotData.counter.toString(),null,new CounterProps(CounterProps.DEFAULT_OFFSET_X,0));
            this._haveCounter = true;
         }
         else if(this._haveCounter)
         {
            this._counterManager.removeCounter(this);
            this._haveCounter = false;
         }
      }
      
      private function hideToolTip() : void
      {
         this._toolTipMgr.hide();
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function get slotIndex() : int
      {
         return this._slotIndex;
      }
      
      public function set slotIndex(param1:int) : void
      {
         this._slotIndex = param1;
      }
      
      [Inspectable]
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
      }
      
      public function get id() : Number
      {
         return this._slotData != null ? Number(this._slotData.id) : Number(NaN);
      }
      
      public function get slotData() : DeviceSlotVO
      {
         return this._slotData;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._slotData && StringUtils.isNotEmpty(this._slotData.tooltipType))
         {
            if(TOOLTIPS_CONSTANTS.COMPLEX == this._slotData.tooltipType)
            {
               this._toolTipMgr.showComplex(this._slotData.tooltip);
            }
            else if(!this.isEmpty())
            {
               this._toolTipMgr.showSpecial(this._slotData.tooltipType,null,this._slotData.id,this._slotData.slotIndex);
            }
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.hideToolTip();
      }
      
      public function get button() : Button
      {
         return this;
      }
   }
}
