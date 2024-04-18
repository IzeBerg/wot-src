package net.wg.gui.components.advanced.collapsingBar
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ResizableButton extends SoundButtonEx
   {
      
      protected static const LAYOUT_INVALID:String = "layoutInv";
       
      
      private var _padding:int = 0;
      
      private var _originSize:Point = null;
      
      private var _baseScaleX:Number = 1;
      
      private var _baseScaleY:Number = 1;
      
      public function ResizableButton()
      {
         super();
      }
      
      public function resetScale() : void
      {
         this._baseScaleX = 1;
         this._baseScaleY = 1;
         setActualScale(this._baseScaleX,this._baseScaleY);
         this.rescaleItems();
      }
      
      override public function get width() : Number
      {
         return super.width * this._baseScaleX;
      }
      
      override public function get height() : Number
      {
         return super.height * this._baseScaleY;
      }
      
      public function get padding() : int
      {
         return this._padding;
      }
      
      public function set padding(param1:int) : void
      {
         this._padding = param1;
      }
      
      public function getOriginSize() : Point
      {
         if(!this._originSize)
         {
            return this._originSize = new Point(this.calculateOriginWidth(),this.calculateOriginHeight());
         }
         return this._originSize;
      }
      
      protected function get tabBar() : CollapsingBar
      {
         return CollapsingBar(owner);
      }
      
      protected function calculateOriginWidth() : int
      {
         return this.tabBar.getTextWidth(this) + (this._padding << 1);
      }
      
      protected function calculateOriginHeight() : int
      {
         this.resetScale();
         return bgMc.height;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         constraintsDisabled = true;
         preventAutosizing = true;
         this.rescaleItems();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.SIZE))
         {
            this.rescaleItems();
         }
         super.draw();
         if(isInvalid(LAYOUT_INVALID) || isInvalid(InvalidationType.SIZE) || isInvalid(InvalidationType.DATA))
         {
            this.updateScale(1 / this.scaleX,1 / this.scaleY);
            this.updateChildPositions();
         }
      }
      
      override protected function canChangeSize(param1:Number) : Boolean
      {
         return this.width != param1 && (!changeSizeOnlyUpwards || changeSizeOnlyUpwards && param1 > this.width);
      }
      
      override protected function onDispose() : void
      {
         this._originSize = null;
         super.onDispose();
      }
      
      private function rescaleItems() : void
      {
         var _loc3_:DisplayObject = null;
         this._baseScaleX = this.scaleX;
         this._baseScaleY = this.scaleY;
         var _loc1_:int = this.numChildren;
         textField.autoSize = TextFieldAutoSize.LEFT;
         this.setActualScale(1,1);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.getChildAt(_loc2_);
            if(this.checkChild(_loc3_))
            {
               _loc3_.scaleX = this._baseScaleX;
               _loc3_.scaleY = this._baseScaleY;
            }
            _loc2_++;
         }
      }
      
      protected function checkChild(param1:DisplayObject) : Boolean
      {
         return param1 != textField;
      }
      
      protected function updateScale(param1:Number, param2:Number) : void
      {
         textField.autoSize = TextFieldAutoSize.LEFT;
         textField.scaleX = param1;
         textField.scaleY = param2;
      }
      
      protected function updateChildPositions() : void
      {
         textField.x = hitMc.width >> 1 - (textField.width >> 1);
      }
   }
}
