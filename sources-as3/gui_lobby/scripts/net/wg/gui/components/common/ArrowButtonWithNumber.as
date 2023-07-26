package net.wg.gui.components.common
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ArrowButtonWithNumber extends SoundButtonEx
   {
      
      private static const NUMBER_POS_X:int = 38;
      
      public static const BTN_TYPE_LEFT:String = "left";
      
      public static const BTN_TYPE_RIGHT:String = "right";
      
      private static const INVALIDATE_INIT_DATA:String = "invInitData";
       
      
      public var arrowContainer:ArrowButtonIconContainer = null;
      
      public var numberCmpnt:ArrowButtonNumber = null;
      
      private var _btnType:String = "left";
      
      public function ArrowButtonWithNumber()
      {
         super();
      }
      
      override protected function preInitialize() : void
      {
         constraintsDisabled = true;
         preventAutosizing = true;
         super.preInitialize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.numberCmpnt.mouseChildren = this.numberCmpnt.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_INIT_DATA))
         {
            this.numberCmpnt.x = this.getNumberXPosition();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            hitMc.height = _height;
            this.numberCmpnt.y = _height >> 1;
            this.arrowContainer.setArrowTopGap(_height >> 1);
         }
      }
      
      override protected function updateDisable() : void
      {
         super.updateDisable();
         this.arrowContainer.enabled = enabled;
      }
      
      override protected function onDispose() : void
      {
         this.arrowContainer.dispose();
         this.arrowContainer = null;
         this.numberCmpnt.dispose();
         this.numberCmpnt = null;
         super.onDispose();
      }
      
      override protected function updateText() : void
      {
         this.numberCmpnt.label = _label;
      }
      
      public function initData(param1:String) : void
      {
         if(this._btnType == param1)
         {
            return;
         }
         this.arrowContainer.init(param1);
         this._btnType = param1;
         invalidate(INVALIDATE_INIT_DATA);
      }
      
      private function getNumberXPosition() : Number
      {
         return this._btnType == BTN_TYPE_LEFT ? Number(NUMBER_POS_X) : Number(-NUMBER_POS_X);
      }
      
      override public function set height(param1:Number) : void
      {
         param1 = Math.max(this.arrowContainer.height,param1);
         super.height = param1;
      }
      
      public function set visiblePagination(param1:Boolean) : void
      {
         this.numberCmpnt.visible = param1;
      }
   }
}
