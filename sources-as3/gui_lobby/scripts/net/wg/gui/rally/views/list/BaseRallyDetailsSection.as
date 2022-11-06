package net.wg.gui.rally.views.list
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.gui.rally.controls.RallyInvalidationType;
   import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.constants.InvalidationType;
   
   public class BaseRallyDetailsSection extends AbtractRallyDetailsSection
   {
       
      
      public var rallyInfoTF:TextField;
      
      public var vehiclesInfoTF:TextField;
      
      public var slotsBg:Sprite = null;
      
      private var _model:IRallyVO;
      
      private var _vehiclesLabel:String = "";
      
      public function BaseRallyDetailsSection()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setChangedVisibilityItems();
         this.slotsBg.visible = false;
         this.slotsBg.mouseChildren = this.slotsBg.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(RallyInvalidationType.VEHICLE_LABEL))
         {
            this.updateVehicleInfoTF();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateElements();
         }
      }
      
      override protected function isModelAvailable() : Boolean
      {
         return this._model && this._model.isAvailable();
      }
      
      override protected function onDispose() : void
      {
         if(this._model != null)
         {
            this._model.dispose();
         }
         this.rallyInfoTF = null;
         this.vehiclesInfoTF = null;
         this.slotsBg = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function setChangedVisibilityItems() : void
      {
         super.setChangedVisibilityItems();
         addItemsToChangedVisibilityList(this.slotsBg,this.rallyInfoTF,this.vehiclesInfoTF);
      }
      
      override protected function updateElements() : void
      {
         super.updateElements();
         if(this.isModelAvailable())
         {
            this.updateSlots(this._model);
         }
      }
      
      override protected function updateElementsVisibility(param1:Boolean) : void
      {
         var _loc3_:IRallySimpleSlotRenderer = null;
         super.updateElementsVisibility(param1);
         var _loc2_:Vector.<IRallySimpleSlotRenderer> = this.getSlots();
         if(_loc2_ != null && _loc2_.length > 0)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.visible = param1;
            }
         }
      }
      
      public function setData(param1:IRallyVO) : void
      {
         this._model = param1;
         invalidateData();
      }
      
      protected function getSlots() : Vector.<IRallySimpleSlotRenderer>
      {
         throw new AbstractException("BaseRallyDetailsSection.getSlots" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function updateVehicleInfoTF() : void
      {
         this.vehiclesInfoTF.htmlText = this._vehiclesLabel;
      }
      
      protected function updateSlots(param1:IRallyVO) : void
      {
         var _loc3_:RallySimpleSlotRenderer = null;
         var _loc2_:Array = param1.slotsArray;
         var _loc4_:Vector.<IRallySimpleSlotRenderer> = this.getSlots();
         for each(_loc3_ in _loc4_)
         {
            _loc3_.slotData = _loc2_[_loc4_.indexOf(_loc3_)];
         }
      }
      
      public function set vehiclesLabel(param1:String) : void
      {
         this._vehiclesLabel = param1;
         invalidate(RallyInvalidationType.VEHICLE_LABEL);
      }
      
      protected function get model() : IRallyVO
      {
         return this._model;
      }
   }
}
