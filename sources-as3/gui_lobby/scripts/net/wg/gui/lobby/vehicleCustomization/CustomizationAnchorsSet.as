package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.interfaces.IMagneticClickHandler;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorInitVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorPositionVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorsStateVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotIdVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotUpdateVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomziationAnchorStateVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationAnchorEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationAnchorSetEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationAnchorsSet extends UIComponentEx implements IMagneticClickHandler
   {
      
      private static const STATE_INVALID:String = "stateInvalid";
       
      
      public var animatedAnchorStateTransitionsEnabled:Boolean = true;
      
      private var _anchorPositionData:Vector.<CustomizationAnchorPositionVO> = null;
      
      private var _anchorItemData:Vector.<CustomizationSlotUpdateVO> = null;
      
      private var _stateData:Object;
      
      private var _rendererData:Vector.<ICustomizationEndPointIcon>;
      
      private var _customizationAnchorInitData:CustomizationAnchorInitVO = null;
      
      private var _selectedId:CustomizationSlotIdVO = null;
      
      private var _numAnchors:int = 0;
      
      private var _rendererFactory:Object;
      
      public function CustomizationAnchorsSet()
      {
         this._stateData = {};
         this._rendererData = new Vector.<ICustomizationEndPointIcon>();
         this._rendererFactory = {};
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:CustomizationEndPointIcon = null;
         var _loc3_:CustomizationSlotUpdateVO = null;
         var _loc4_:String = null;
         super.draw();
         var _loc2_:Array = [];
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._anchorItemData)
            {
               for each(_loc3_ in this._anchorItemData)
               {
                  _loc2_[_loc3_.uid] = _loc3_;
               }
               for each(_loc1_ in this._rendererData)
               {
                  _loc1_.setSlotData(_loc2_[_loc1_.slotData.uid]);
               }
               this.setSelectedSlot(this._selectedId);
            }
         }
         if(isInvalid(STATE_INVALID))
         {
            for each(_loc1_ in this._rendererData)
            {
               _loc4_ = _loc1_.slotData.uid.toString();
               if(this._stateData.hasOwnProperty(_loc4_))
               {
                  _loc1_.applyState(this._stateData[_loc4_],this.animatedAnchorStateTransitionsEnabled);
               }
            }
            this.animatedAnchorStateTransitionsEnabled = true;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._rendererFactory[CUSTOMIZATION_ALIASES.ANCHOR_TYPE_REGION] = App.instance.utils.classFactory.getClass(Linkages.CUSTOMIZATION_END_POINT_LINKAGE);
         this._rendererFactory[CUSTOMIZATION_ALIASES.ANCHOR_TYPE_DECAL] = App.instance.utils.classFactory.getClass(Linkages.CUSTOMIZATION_ANCHOR_RENDERER_LINKAGE);
         this._rendererFactory[CUSTOMIZATION_ALIASES.ANCHOR_TYPE_PROJECTION_DECAL] = App.instance.utils.classFactory.getClass(Linkages.CUSTOMIZATION_DECAL_ANCHOR_RENDERER_LINKAGE);
         addEventListener(CustomizationAnchorEvent.SELECT_ANCHOR,this.onSelectAnchorHandler);
      }
      
      override protected function onBeforeDispose() : void
      {
         removeEventListener(CustomizationAnchorEvent.SELECT_ANCHOR,this.onSelectAnchorHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.clearPositionData();
         this.clearRendererData();
         this.clearUpdateData();
         App.utils.data.cleanupDynamicObject(this._rendererFactory);
         this._rendererFactory = null;
         App.utils.data.cleanupDynamicObject(this._stateData);
         this._stateData = null;
         super.onDispose();
      }
      
      public function deselectCurrentAnchor() : void
      {
         var _loc1_:CustomizationEndPointIcon = this.getRendererById(this._selectedId);
         if(_loc1_ != null)
         {
            _loc1_.selected = false;
         }
         this._selectedId = null;
      }
      
      public function getRendererById(param1:CustomizationSlotIdVO) : CustomizationEndPointIcon
      {
         var _loc2_:CustomizationEndPointIcon = null;
         if(param1 == null)
         {
            return null;
         }
         for each(_loc2_ in this._rendererData)
         {
            if(_loc2_ != null && _loc2_.id != null && _loc2_.id.isEquals(param1))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getSelectedSlotId() : CustomizationSlotIdVO
      {
         return this._selectedId;
      }
      
      public function getSlotDataById(param1:CustomizationSlotIdVO) : CustomizationSlotUpdateVO
      {
         var _loc2_:int = this.getUpdateIndexByAnchorId(param1);
         return _loc2_ != Values.DEFAULT_INT ? this._anchorItemData[_loc2_] : null;
      }
      
      public function highlightAnchor(param1:CustomizationSlotIdVO) : void
      {
         var _loc2_:CustomizationEndPointIcon = null;
         if(!param1)
         {
            return;
         }
         for each(_loc2_ in this._rendererData)
         {
            if(_loc2_ != null && _loc2_.slotData && _loc2_.slotData.slotId)
            {
               if(_loc2_.slotData.slotId.isEquals(param1))
               {
                  _loc2_.playZoomIn();
               }
               else
               {
                  _loc2_.playZoomOut();
               }
            }
         }
      }
      
      public function onAfterDrop() : void
      {
         var _loc1_:ICustomizationEndPointIcon = null;
         for each(_loc1_ in this._rendererData)
         {
            if(_loc1_ && _loc1_ is CustomizationAnchorRenderer)
            {
               _loc1_.onDragTargetChange(false);
               _loc1_.enabled = true;
            }
         }
      }
      
      public function onDragEnd() : void
      {
         var _loc1_:ICustomizationEndPointIcon = null;
         for each(_loc1_ in this._rendererData)
         {
            if(_loc1_ && _loc1_ is CustomizationAnchorRenderer)
            {
               _loc1_.onDragEnd();
            }
         }
      }
      
      public function onDragStart() : void
      {
         var _loc1_:ICustomizationEndPointIcon = null;
         for each(_loc1_ in this._rendererData)
         {
            if(_loc1_ && _loc1_ is CustomizationAnchorRenderer)
            {
               _loc1_.onDragStart();
            }
         }
      }
      
      public function onMagneticReset() : void
      {
         var _loc1_:CustomizationEndPointIcon = null;
         for each(_loc1_ in this._rendererData)
         {
            _loc1_.onMagneticReset();
         }
      }
      
      public function onStartDrop() : void
      {
         var _loc1_:ICustomizationEndPointIcon = null;
         for each(_loc1_ in this._rendererData)
         {
            if(_loc1_ && _loc1_ is CustomizationAnchorRenderer)
            {
               _loc1_.onDragTargetChange(true);
            }
         }
      }
      
      public function setAnchorsState(param1:CustomizationAnchorsStateVO) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:CustomziationAnchorStateVO = null;
         var _loc4_:int = 0;
         if(param1.anchorsData)
         {
            _loc2_ = false;
            if(!this.animatedAnchorStateTransitionsEnabled)
            {
               for each(_loc4_ in this._stateData)
               {
                  if(_loc4_ == CUSTOMIZATION_ALIASES.ANCHOR_STATE_LOCKED)
                  {
                     _loc2_ = true;
                     this.animatedAnchorStateTransitionsEnabled = true;
                     break;
                  }
               }
            }
            App.utils.data.cleanupDynamicObject(this._stateData);
            for each(_loc3_ in param1.anchorsData)
            {
               this._stateData[_loc3_.uid] = _loc3_.value;
               if(_loc2_ && _loc3_.value == CUSTOMIZATION_ALIASES.ANCHOR_STATE_LOCKED)
               {
                  this.animatedAnchorStateTransitionsEnabled = false;
               }
            }
            invalidate(STATE_INVALID);
            validateNow();
         }
      }
      
      public function setInitData(param1:CustomizationAnchorInitVO) : void
      {
         var _loc2_:Vector.<uint> = null;
         var _loc3_:Vector.<uint> = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:CustomizationEndPointIcon = null;
         var _loc7_:CustomizationSlotUpdateVO = null;
         var _loc8_:int = 0;
         var _loc9_:Vector.<ICustomizationEndPointIcon> = null;
         this.clearPositionData();
         this.clearUpdateData();
         this._anchorItemData = param1.anchorUpdateVOs;
         this._numAnchors = Boolean(this._anchorItemData) ? int(this._anchorItemData.length) : int(0);
         if(this._numAnchors > 0)
         {
            _loc2_ = new Vector.<uint>();
            _loc3_ = new Vector.<uint>();
            _loc4_ = [];
            _loc5_ = [];
            for each(_loc6_ in this._rendererData)
            {
               _loc2_.push(_loc6_.slotData.uid);
            }
            for each(_loc7_ in this._anchorItemData)
            {
               _loc3_.push(_loc7_.uid);
               _loc4_[_loc7_.uid] = _loc7_;
            }
            _loc8_ = 0;
            while(_loc8_ < this._numAnchors)
            {
               if(_loc2_.indexOf(this._anchorItemData[_loc8_].uid) == -1)
               {
                  _loc6_ = new this._rendererFactory[param1.typeRegions]();
                  addChild(DisplayObject(_loc6_));
                  this._rendererData.push(_loc6_);
                  _loc6_.setSlotData(this._anchorItemData[_loc8_]);
               }
               _loc8_++;
            }
            _loc9_ = this._rendererData.slice();
            for each(_loc6_ in _loc9_)
            {
               if(_loc3_.indexOf(_loc6_.slotData.uid) == -1)
               {
                  this._rendererData.splice(this._rendererData.indexOf(_loc6_),1);
                  this.clearRenderer(_loc6_);
               }
            }
            for each(_loc6_ in this._rendererData)
            {
               _loc6_.setSlotData(_loc4_[_loc6_.slotData.uid]);
               _loc6_.selected = false;
               _loc5_.push(_loc6_);
            }
            this.setSelectedSlot(this._selectedId);
            dispatchEvent(new CustomizationAnchorSetEvent(CustomizationAnchorSetEvent.ANCHORS_FILLED,_loc5_));
         }
      }
      
      public function setSelectedSlot(param1:CustomizationSlotIdVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:CustomizationEndPointIcon = this.getRendererById(this._selectedId);
         if(_loc2_ != null)
         {
            _loc2_.selected = false;
         }
         var _loc3_:CustomizationEndPointIcon = this.getRendererById(param1);
         if(_loc3_ != null)
         {
            _loc3_.selected = true;
         }
         this._selectedId = param1;
      }
      
      public function updateAnchor(param1:CustomizationSlotIdVO, param2:int) : void
      {
         var _loc3_:CustomizationSlotUpdateVO = null;
         if(param1 != null)
         {
            _loc3_ = this.getSlotDataById(param1);
            if(_loc3_)
            {
               _loc3_.itemIntCD = param2;
               invalidateData();
            }
         }
      }
      
      public function updateData(param1:CustomizationAnchorInitVO) : void
      {
         if(param1 != null)
         {
            this._customizationAnchorInitData = param1;
            if(param1.anchorUpdateVOs != null)
            {
               this._anchorItemData = param1.anchorUpdateVOs;
            }
            invalidateData();
         }
      }
      
      public function updatePositions(param1:Vector.<CustomizationAnchorPositionVO>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ICustomizationEndPointIcon = null;
         var _loc4_:CustomizationAnchorPositionVO = null;
         this._anchorPositionData = param1;
         this._numAnchors = Math.min(this._anchorPositionData.length,this._numAnchors);
         _loc2_ = 0;
         while(_loc2_ < this._numAnchors)
         {
            _loc4_ = this._anchorPositionData[_loc2_];
            _loc3_ = this._rendererData[_loc4_.zIndex];
            _loc2_++;
         }
         invalidateData();
      }
      
      private function clearRendererData() : void
      {
         var _loc1_:CustomizationEndPointIcon = null;
         if(this._rendererData)
         {
            for each(_loc1_ in this._rendererData)
            {
               this.clearRenderer(_loc1_);
            }
            this._rendererData.splice(0,this._rendererData.length);
            this._rendererData = null;
         }
         this._selectedId = null;
      }
      
      private function clearRenderer(param1:CustomizationEndPointIcon) : void
      {
         if(contains(param1))
         {
            removeChild(param1);
         }
         param1.dispose();
      }
      
      private function clearPositionData() : void
      {
         var _loc1_:CustomizationAnchorPositionVO = null;
         if(this._anchorPositionData)
         {
            for each(_loc1_ in this._anchorPositionData)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            this._anchorPositionData.splice(0,this._anchorPositionData.length);
            this._anchorPositionData = null;
         }
      }
      
      private function clearUpdateData() : void
      {
         var _loc1_:CustomizationSlotUpdateVO = null;
         if(this._anchorItemData)
         {
            for each(_loc1_ in this._anchorItemData)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            this._anchorItemData = this._anchorItemData.splice(0,this._anchorItemData.length);
            this._anchorItemData = null;
         }
         this._customizationAnchorInitData = null;
      }
      
      private function getUpdateIndexByAnchorId(param1:CustomizationSlotIdVO) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = this._anchorItemData != null ? int(this._anchorItemData.length) : int(0);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this._anchorItemData[_loc2_].slotId.isEquals(param1))
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return Values.DEFAULT_INT;
      }
      
      public function handleLeftClick(param1:MouseEvent) : Boolean
      {
         return DisplayObject(param1.target).parent == this;
      }
      
      private function onSelectAnchorHandler(param1:CustomizationAnchorEvent) : void
      {
         var _loc2_:CustomizationSlotIdVO = param1.anchor.id;
         if(_loc2_ != null)
         {
            this.setSelectedSlot(_loc2_);
         }
      }
   }
}
