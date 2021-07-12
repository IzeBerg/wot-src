package net.wg.gui.components.tooltips
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.tooltips.VO.CustomizationItemVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import scaleform.clik.utils.Padding;
   
   public class ToolTipCustomizationItem extends ToolTipBase
   {
      
      private static const TOP_PADDINGS_IDX:int = 0;
      
      private static const LEFT_PADDINGS_IDX:int = 1;
      
      private static const BOTTOM_PADDING:int = 20;
      
      private static const DEFAULT_CONTENT_MARGIN:Padding = new Padding(12,-25,12,17);
      
      private static const HEADER_TF_PADDING:Array = [16,20];
      
      private static const KIND_TF_PADDING:Array = [-2,20];
      
      private static const SEPARATOR_AFTER_KIND_PADDING:Array = [11,0];
      
      private static const DESCRIPTION_TF_PADDING:Array = [8,20];
      
      private static const SEPARATOR_AFTER_DESC_PADDING:Array = [14,0];
      
      private static const TIME_LEFT_TF_PADDING:Array = [7,20];
      
      private static const SEPARATOR_AFTER_TIME_LEFT_PADDING:Array = [10,0];
      
      private static const VEHICLE_TYPE_TF_PADDING:Array = [7,20];
       
      
      private var headerTF:TextField = null;
      
      private var kindTF:TextField = null;
      
      private var descriptionTF:TextField = null;
      
      private var timeLeftTF:TextField = null;
      
      private var vehicleTypeTF:TextField = null;
      
      private var paddings:Object = null;
      
      private var displayedElements:Vector.<DisplayObject> = null;
      
      public function ToolTipCustomizationItem()
      {
         super();
         this.headerTF = content.headerTF;
         this.kindTF = content.kindTF;
         this.descriptionTF = content.descriptionTF;
         this.timeLeftTF = content.timeLeftTF;
         this.vehicleTypeTF = content.vehicleTypeTF;
         contentMargin = DEFAULT_CONTENT_MARGIN;
         this.init();
      }
      
      override protected function redraw() : void
      {
         super.redraw();
         this.updateTextFieldsFromData();
         this.updateSize();
      }
      
      override protected function onDispose() : void
      {
         this.headerTF = null;
         this.kindTF = null;
         this.descriptionTF = null;
         this.timeLeftTF = null;
         this.vehicleTypeTF = null;
         while(this.displayedElements.length > 0)
         {
            removeChild(this.displayedElements.pop());
         }
         this.displayedElements = null;
         this.paddings = App.utils.data.cleanupDynamicObject(this.paddings);
         this.paddings = null;
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         var _loc1_:int = this.displayedElements.length;
         var _loc2_:int = _loc1_ - 1;
         while(_loc2_ > 0)
         {
            if(this.displayedElements[_loc2_].visible)
            {
               background.height = this.displayedElements[_loc2_].y + this.displayedElements[_loc2_].height + BOTTOM_PADDING;
               break;
            }
            _loc2_--;
         }
      }
      
      private function getNewSeparator() : Separator
      {
         var _loc1_:Separator = Utils.instance.createSeparate(content);
         if(separators == null)
         {
            separators = new Vector.<Separator>(0);
         }
         separators.push(_loc1_);
         return _loc1_;
      }
      
      private function init() : void
      {
         var _loc1_:Separator = this.getNewSeparator();
         var _loc2_:Separator = this.getNewSeparator();
         var _loc3_:Separator = this.getNewSeparator();
         this.displayedElements = new <DisplayObject>[this.headerTF,this.kindTF,_loc1_,this.descriptionTF,_loc2_,this.timeLeftTF,_loc3_,this.vehicleTypeTF];
         this.paddings = {};
         this.paddings[this.headerTF.name] = HEADER_TF_PADDING;
         this.paddings[this.kindTF.name] = KIND_TF_PADDING;
         this.paddings[_loc1_.name] = SEPARATOR_AFTER_KIND_PADDING;
         this.paddings[this.descriptionTF.name] = DESCRIPTION_TF_PADDING;
         this.paddings[_loc2_.name] = SEPARATOR_AFTER_DESC_PADDING;
         this.paddings[this.timeLeftTF.name] = TIME_LEFT_TF_PADDING;
         this.paddings[_loc3_.name] = SEPARATOR_AFTER_TIME_LEFT_PADDING;
         this.paddings[this.vehicleTypeTF.name] = VEHICLE_TYPE_TF_PADDING;
         this.customizeTextFields();
      }
      
      private function updatePositions() : void
      {
         var _loc4_:DisplayObject = null;
         var _loc1_:int = 0;
         var _loc2_:int = this.displayedElements.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.displayedElements[_loc3_];
            if(_loc4_.visible)
            {
               _loc4_.x = this.getPaddingForElement(_loc4_,LEFT_PADDINGS_IDX);
               _loc4_.y = this.getPaddingForElement(_loc4_,TOP_PADDINGS_IDX) + _loc1_;
               _loc1_ = _loc4_.y + _loc4_.height;
            }
            _loc3_++;
         }
      }
      
      private function getPaddingForElement(param1:DisplayObject, param2:int) : int
      {
         return this.paddings[param1.name][param2];
      }
      
      private function customizeTextFields() : void
      {
         var _loc3_:TextField = null;
         var _loc1_:int = this.displayedElements.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.displayedElements[_loc2_] as TextField;
            if(_loc3_ != null)
            {
               _loc3_.autoSize = TextFieldAutoSize.LEFT;
               _loc3_.selectable = false;
            }
            _loc2_++;
         }
      }
      
      private function changeVisibility(param1:TextField, param2:Boolean) : void
      {
         var _loc3_:int = this.displayedElements.indexOf(param1);
         this.displayedElements[_loc3_].visible = param2;
         if(_loc3_ - 1 >= 0 && this.displayedElements[_loc3_ - 1] is Separator)
         {
            this.displayedElements[_loc3_ - 1].visible = param2;
         }
      }
      
      private function updateTextFieldsFromData() : void
      {
         var _loc1_:CustomizationItemVO = new CustomizationItemVO(_data);
         this.headerTF.htmlText = _loc1_.header;
         this.kindTF.htmlText = _loc1_.kind;
         this.descriptionTF.htmlText = _loc1_.description;
         this.changeVisibility(this.descriptionTF,_loc1_.description.length > 0);
         this.timeLeftTF.htmlText = _loc1_.timeLeft;
         this.changeVisibility(this.timeLeftTF,_loc1_.timeLeft.length > 0);
         this.vehicleTypeTF.htmlText = _loc1_.vehicleType;
         this.changeVisibility(this.vehicleTypeTF,_loc1_.vehicleType.length > 0);
         this.updatePositions();
      }
   }
}
