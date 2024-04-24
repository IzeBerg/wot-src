package net.wg.gui.components.controls.slotsPanel.impl
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.advanced.interfaces.ICooldownSlot;
   import net.wg.gui.components.controls.VO.SlotVO;
   import net.wg.gui.components.controls.VO.SlotsPanelPropsVO;
   import net.wg.gui.components.controls.events.SlotsPanelEvent;
   import net.wg.gui.components.controls.slotsPanel.ISlotsPanel;
   import net.wg.infrastructure.base.meta.impl.SlotsPanelMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseSlotsPanel extends SlotsPanelMeta implements ISlotsPanel
   {
      
      private static const INV_SLOT:String = "invSlot";
      
      private static const GROUP_OFFSET:int = -1;
      
      private static const GROUP_OFFSET_PADDING:int = -3;
      
      private static const SLOT_OFFSET:int = 5;
       
      
      private var _invalidData:Vector.<SlotVO> = null;
      
      private var _group:int = -1;
      
      private var _inited:Boolean = false;
      
      private var _storeSlots:Vector.<ICooldownSlot> = null;
      
      private var _allGroupId:int;
      
      private var _slots:Vector.<ICooldownSlot> = null;
      
      private var _slotsData:Vector.<SlotVO> = null;
      
      private var _props:SlotsPanelPropsVO = null;
      
      private var _tooltip:String;
      
      public function BaseSlotsPanel(param1:int = -1)
      {
         super();
         this._invalidData = new Vector.<SlotVO>();
         this._storeSlots = new Vector.<ICooldownSlot>();
         this._allGroupId = param1;
      }
      
      override protected function onDispose() : void
      {
         this.tryDisposeSlots();
         this.tryClearInvalidData();
         this._slotsData = null;
         this.tryDisposeStoreSlots();
         this._props = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:SlotVO = null;
         super.draw();
         if(this._invalidData.length > 0 && isInvalid(INV_SLOT))
         {
            for each(_loc1_ in this._invalidData)
            {
               this.internallyUpdateSlot(_loc1_);
               this.syncNewData(_loc1_);
            }
            this._invalidData.splice(0,this._invalidData.length);
         }
      }
      
      override protected function setPanelProps(param1:SlotsPanelPropsVO) : void
      {
         this._props = param1;
      }
      
      override protected function setSlots(param1:Vector.<SlotVO>) : void
      {
         var _loc2_:SlotVO = null;
         this._inited = true;
         this._slotsData = param1;
         for each(_loc2_ in this._slotsData)
         {
            this.internallyUpdateSlot(_loc2_);
         }
         dispatchEvent(new SlotsPanelEvent(SlotsPanelEvent.ON_DATA_SET));
      }
      
      override protected function updateSlot(param1:SlotVO) : void
      {
         if(!this._slotsData || this._slotsData.length == 0)
         {
            App.utils.asserter.assert(false,"Slots data" + Errors.CANT_EMPTY);
         }
         this._invalidData.push(param1);
         invalidate(INV_SLOT);
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function isInited() : Boolean
      {
         return this._inited;
      }
      
      public function isShowCheckBox(param1:int) : Boolean
      {
         var _loc2_:int = this._slotsData.length;
         var _loc3_:int = this._props.groupCount + GROUP_OFFSET;
         var _loc4_:int = this._props.groupPadding + GROUP_OFFSET_PADDING;
         var _loc5_:int = _loc2_ * this._props.slotWidth + _loc3_ * _loc4_;
         return param1 - this._props.paddings <= _loc5_;
      }
      
      public function redrawSlots(param1:int, param2:Boolean = false) : void
      {
         if(this._group == param1)
         {
            dispatchEvent(new SlotsPanelEvent(SlotsPanelEvent.NEED_REPOSITION));
            if(!param2)
            {
               return;
            }
         }
         this._group = param1;
         this.drawSlots();
      }
      
      protected function getSlotsOffset() : int
      {
         return SLOT_OFFSET;
      }
      
      protected function removeNotNeeded(param1:ICooldownSlot, param2:SlotVO) : Boolean
      {
         return param1.id == param2.id && param1.isCooolDownInProgress;
      }
      
      protected function setSlotData(param1:ICooldownSlot, param2:SlotVO) : void
      {
         param1.data = param2;
         param1.id = param2.id;
         param1.icon = param2.icon;
         param1.isInactive = param2.isInactive;
         param1.onlyLeftButton = this._props.useOnlyLeftBtn;
         param1.isDischarging = param2.isDischarging;
         if(param2.inCooldown)
         {
            param1.setCoolDownPosAsPercent(param2.cooldownPercent);
            if(!param2.isPermanent)
            {
               param1.setCooldown(param2.leftTime);
            }
         }
         else
         {
            param1.clearCoolDownTime();
         }
      }
      
      override protected function getSlotVOOfItemForOrders(param1:Object) : SlotVO
      {
         return new SlotVO(param1);
      }
      
      override protected function getSlotVOForData(param1:Object) : SlotVO
      {
         return this.getSlotVOOfItemForOrders(param1);
      }
      
      protected function createSlot(param1:SlotVO) : ICooldownSlot
      {
         throw new AbstractException("BaseSlotsPanel.createSlot" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function drawSlots() : void
      {
         var _loc2_:SlotVO = null;
         var _loc3_:ICooldownSlot = null;
         var _loc4_:ICooldownSlot = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         this.clearSlots();
         this._slots = new Vector.<ICooldownSlot>(0);
         var _loc1_:int = this._slotsData.length;
         _loc6_ = 0;
         while(_loc6_ < _loc1_)
         {
            _loc2_ = this._slotsData[_loc6_];
            if(!(this._group != this._allGroupId && this._group != _loc2_.group))
            {
               _loc5_ = true;
               if(this._storeSlots.length > 0)
               {
                  _loc7_ = this._storeSlots.length;
                  _loc8_ = -1;
                  _loc9_ = 0;
                  while(_loc9_ < _loc7_)
                  {
                     _loc4_ = this._storeSlots[_loc9_];
                     if(_loc4_.id == _loc2_.id)
                     {
                        _loc3_ = _loc4_;
                        _loc8_ = _loc9_;
                        _loc5_ = false;
                        break;
                     }
                     _loc9_++;
                  }
                  if(_loc8_ > -1)
                  {
                     this._storeSlots.splice(_loc8_,1);
                     _loc8_ = -1;
                  }
               }
               if(_loc5_)
               {
                  _loc3_ = this.createSlot(_loc2_);
               }
               _loc3_.soundType = SoundTypes.NORMAL_BTN;
               _loc3_.mouseEnabledOnDisabled = true;
               if(_loc5_)
               {
                  this.setSlotData(_loc3_,_loc2_);
               }
               this.setupSlot(_loc3_,_loc2_);
               this.addChild(_loc3_.displayObject);
               this._slots.push(_loc3_);
            }
            _loc6_++;
         }
         this.layoutSlots();
         invalidateSize();
         invalidateData();
         dispatchEvent(new SlotsPanelEvent(SlotsPanelEvent.NEED_REPOSITION));
      }
      
      protected function layoutSlots() : void
      {
         var _loc4_:SlotVO = null;
         var _loc5_:ICooldownSlot = null;
         var _loc6_:int = 0;
         var _loc1_:int = this.getSlotsOffset();
         var _loc2_:int = -1;
         var _loc3_:int = this._slotsData.length;
         var _loc7_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = this._slotsData[_loc6_];
            if(!(this._group != this._allGroupId && this._group != _loc4_.group))
            {
               _loc5_ = this._slots[_loc7_++];
               if(_loc2_ != -1 && _loc4_.type != _loc2_)
               {
                  _loc1_ += this._props.groupPadding;
                  _loc2_ = _loc4_.type;
               }
               if(_loc2_ == -1)
               {
                  _loc2_ = _loc4_.type;
               }
               _loc5_.y = this._props.ySlotPosition;
               _loc5_.x = _loc1_;
               _loc1_ += _loc5_.width + this._props.offsetSlot;
            }
            _loc6_++;
         }
      }
      
      protected function setupSlot(param1:ICooldownSlot, param2:SlotVO) : void
      {
         param1.enabled = !param2.isInactive;
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.onSlotMouseOverHandler);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onSlotMouseOutHandler);
      }
      
      protected function cleanUpSlot(param1:ICooldownSlot) : void
      {
         param1.removeEventListener(MouseEvent.MOUSE_OVER,this.onSlotMouseOverHandler);
         param1.removeEventListener(MouseEvent.MOUSE_OUT,this.onSlotMouseOutHandler);
      }
      
      protected function canUpdate(param1:ICooldownSlot, param2:SlotVO) : Boolean
      {
         return param1.id == param2.id;
      }
      
      protected function showSlotTooltip(param1:ICooldownSlot) : void
      {
         throw new AbstractException("BaseSlotsPanel.showSlotTooltip" + Errors.ABSTRACT_INVOKE);
      }
      
      private function clearSlots() : void
      {
         var _loc2_:ICooldownSlot = null;
         var _loc3_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this._slots == null)
         {
            return;
         }
         var _loc1_:int = this._slots.length;
         var _loc4_:int = this._slotsData.length;
         _loc5_ = 0;
         while(_loc5_ < _loc1_)
         {
            _loc2_ = this._slots[_loc5_];
            _loc3_ = true;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               if(this.removeNotNeeded(_loc2_,this._slotsData[_loc6_]))
               {
                  this._storeSlots.push(_loc2_);
                  _loc3_ = false;
                  break;
               }
               _loc6_++;
            }
            this.cleanUpSlot(_loc2_);
            if(_loc3_)
            {
               _loc2_.dispose();
            }
            this.removeChild(_loc2_.displayObject);
            _loc5_++;
         }
         this._slots.splice(0,this._slots.length);
         this._slots = null;
      }
      
      private function hideSlotTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      private function tryClearInvalidData() : void
      {
         this._invalidData.splice(0,this._invalidData.length);
         this._invalidData = null;
      }
      
      private function internallyUpdateSlot(param1:SlotVO) : void
      {
         var _loc2_:ICooldownSlot = null;
         for each(_loc2_ in this._slots)
         {
            if(this.canUpdate(_loc2_,param1))
            {
               this.setSlotData(_loc2_,param1);
               break;
            }
         }
      }
      
      private function tryDisposeStoreSlots() : void
      {
         var _loc1_:ICooldownSlot = null;
         for each(_loc1_ in this._storeSlots)
         {
            this.cleanUpSlot(_loc1_);
            _loc1_.dispose();
         }
         this._storeSlots.splice(0,this._storeSlots.length);
         this._storeSlots = null;
      }
      
      private function tryDisposeSlots() : void
      {
         var _loc1_:ICooldownSlot = null;
         if(this._slots != null)
         {
            for each(_loc1_ in this._slots)
            {
               this.cleanUpSlot(_loc1_);
               _loc1_.dispose();
            }
            this._slots.splice(0,this._slots.length);
            this._slots = null;
         }
      }
      
      private function syncNewData(param1:SlotVO) : void
      {
         var _loc2_:int = this._slotsData.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._slotsData[_loc3_].id == param1.id)
            {
               this._slotsData[_loc3_].dispose();
               this._slotsData[_loc3_] = param1;
               break;
            }
            _loc3_++;
         }
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      protected function get slots() : Vector.<ICooldownSlot>
      {
         return this._slots;
      }
      
      protected function get slotsData() : Vector.<SlotVO>
      {
         return this._slotsData;
      }
      
      protected function get props() : SlotsPanelPropsVO
      {
         return this._props;
      }
      
      private function onSlotMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ICooldownSlot = ICooldownSlot(param1.currentTarget);
         this._tooltip = getSlotTooltipBodyS(_loc2_.id);
         this.showSlotTooltip(_loc2_);
      }
      
      private function onSlotMouseOutHandler(param1:MouseEvent) : void
      {
         this.hideSlotTooltip();
      }
   }
}
