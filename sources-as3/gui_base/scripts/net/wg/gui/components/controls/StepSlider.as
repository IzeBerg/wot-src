package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.interfaces.ISliderKeyPoint;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.SliderEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   [InspectableList("valueLabel")]
   public class StepSlider extends Slider
   {
      
      private static const INVALID_KEY_POINT_RENDERER:String = "invalidKeyPointRenderer";
      
      protected static const INVALID_VALUE_LABEL:String = "invalidValueLabel";
      
      private static const DISABLED_KEY_POINT_ALPHA:Number = 0.3;
      
      private static const ENABLED_KEY_POINT_ALPHA:Number = 1;
       
      
      public var keyPointsContainer:Sprite;
      
      private var _dataProvider:IDataProvider;
      
      private var _keyPointRenderer:String = "SliderKeyPointUI";
      
      private var _valueLabel:String = null;
      
      protected var valueLabelControl:DisplayObject;
      
      public function StepSlider()
      {
         super();
         snapping = true;
         snapInterval = 1;
         minimum = 0;
      }
      
      private static function onThumbOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(SliderEvent.VALUE_CHANGE,this.onValueChanged);
         thumb.addEventListener(MouseEvent.ROLL_OVER,this.onThumbOver);
         thumb.addEventListener(MouseEvent.ROLL_OUT,onThumbOut);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_VALUE_LABEL))
         {
            if(this._valueLabel && parent)
            {
               this.valueLabelControl = parent[this._valueLabel];
               this.updateValueLabel();
            }
         }
         if(isInvalid(INVALID_KEY_POINT_RENDERER) || isInvalid(InvalidationType.DATA))
         {
            this.updateMaxAvailableValue();
            this.redrawKeyPoints();
            updateThumb();
         }
         updatePatterns();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(SliderEvent.VALUE_CHANGE,this.onValueChanged);
         thumb.removeEventListener(MouseEvent.ROLL_OVER,this.onThumbOver);
         thumb.removeEventListener(MouseEvent.ROLL_OUT,onThumbOut);
         this.clearKeyPoints();
         this.keyPointsContainer = null;
         if(this.valueLabelControl)
         {
            this.valueLabelControl = null;
         }
         if(this._dataProvider)
         {
            this._dataProvider.cleanUp();
            this._dataProvider = null;
         }
         super.onDispose();
      }
      
      protected function getItemLabel(param1:Object) : String
      {
         var _loc2_:String = "";
         if(param1)
         {
            if(param1 is String)
            {
               _loc2_ = param1 as String;
            }
            else if(param1.hasOwnProperty("label"))
            {
               _loc2_ = param1["label"];
            }
         }
         return _loc2_;
      }
      
      protected function getItemTooltip(param1:Object) : String
      {
         return this.getItemLabel(param1);
      }
      
      private function onValueChanged(param1:SliderEvent) : void
      {
         this.updateValueLabel();
      }
      
      protected function updateValueLabel() : void
      {
         if(this.valueLabelControl)
         {
            if(this._dataProvider && this._dataProvider.length > 0)
            {
               this.valueLabelControl["text"] = this.getItemLabel(this._dataProvider.requestItemAt(value));
            }
            else
            {
               this.valueLabelControl["text"] = "";
            }
         }
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         this._dataProvider = param1;
         maximum = this._dataProvider && this._dataProvider.length > 0 ? Number(this._dataProvider.length - 1) : Number(0);
         invalidateData();
      }
      
      [Inspectable(defaultValue="SliderKeyPointUI",name="keyPointRenderer")]
      public function get keyPointRenderer() : String
      {
         return this._keyPointRenderer;
      }
      
      public function set keyPointRenderer(param1:String) : void
      {
         this._keyPointRenderer = param1;
         invalidate(INVALID_KEY_POINT_RENDERER);
      }
      
      protected function checkIsItemDisabled(param1:Object) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1.hasOwnProperty("enabled") && !param1["enabled"])
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function updateMaxAvailableValue() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:Object = null;
         if(this._dataProvider)
         {
            _loc1_ = this._dataProvider.length;
            _loc2_ = NaN;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc4_ = this._dataProvider.requestItemAt(_loc3_);
               if(!(_loc4_ is String))
               {
                  _loc5_ = _loc4_ as Object;
                  if(_loc5_ && this.checkIsItemDisabled(_loc5_))
                  {
                     _loc2_ = _loc3_ - 1;
                     break;
                  }
               }
               _loc3_++;
            }
            maxAvailableValue = _loc2_;
         }
      }
      
      private function redrawKeyPoints() : void
      {
         var _loc1_:ISliderKeyPoint = null;
         this.clearKeyPoints();
         if(!this._dataProvider || this._dataProvider.length == 0)
         {
            return;
         }
         var _loc2_:Number = track.width - offsetLeft - offsetRight;
         var _loc3_:int = this._dataProvider.length;
         var _loc4_:Number = _loc2_ / (_loc3_ - 1);
         var _loc5_:Class = App.utils.classFactory.getClass(this._keyPointRenderer);
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc1_ = App.utils.classFactory.getComponent(this._keyPointRenderer,_loc5_);
            _loc1_.x = _loc6_ * _loc4_ ^ 0;
            _loc1_.tooltip = this.getItemTooltip(this._dataProvider.requestItemAt(_loc6_));
            _loc1_.index = _loc6_;
            _loc1_.alpha = _loc6_ > maxAvailableValue ? Number(DISABLED_KEY_POINT_ALPHA) : Number(ENABLED_KEY_POINT_ALPHA);
            _loc1_.addEventListener(MouseEvent.CLICK,this.onKeyPointClick);
            this.keyPointsContainer.addChild(DisplayObject(_loc1_));
            _loc6_++;
         }
      }
      
      private function onKeyPointClick(param1:MouseEvent) : void
      {
         var _loc2_:SliderKeyPoint = param1.currentTarget as SliderKeyPoint;
         App.utils.asserter.assertNotNull(_loc2_,"sliderKeyPoint" + Errors.CANT_NULL);
         value = _loc2_.index;
      }
      
      private function onThumbOver(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(this.getItemTooltip(this._dataProvider.requestItemAt(value)));
      }
      
      private function clearKeyPoints() : void
      {
         var _loc1_:ISliderKeyPoint = null;
         while(this.keyPointsContainer.numChildren)
         {
            _loc1_ = ISliderKeyPoint(this.keyPointsContainer.getChildAt(0));
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onKeyPointClick);
            this.keyPointsContainer.removeChild(DisplayObject(_loc1_));
            _loc1_.dispose();
         }
      }
      
      [Inspectable(defaultValue="",name="valueLabel")]
      public function get valueLabel() : String
      {
         return this._valueLabel;
      }
      
      public function set valueLabel(param1:String) : void
      {
         this._valueLabel = param1;
         invalidate(INVALID_VALUE_LABEL);
      }
   }
}
