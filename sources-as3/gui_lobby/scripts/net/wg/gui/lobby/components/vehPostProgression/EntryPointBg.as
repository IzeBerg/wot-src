package net.wg.gui.lobby.components.vehPostProgression
{
   import flash.display.Sprite;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class EntryPointBg extends UIComponentEx
   {
      
      private static const BG_COLOR:uint = 986895;
      
      private static const BORDER_COLOR:uint = 16777215;
      
      private static const BG_ALPHA:Number = 0.3;
      
      private static const BORDER_ALPHA:Number = 0.15;
      
      private static const BG_ALPHA_HOVER:Number = 0.6;
      
      private static const BORDER_ALPHA_HOVER:Number = 0.3;
      
      private static const CORNER_ALPHA:Number = 0.5;
      
      private static const CORNER_SIZE:Number = 2;
      
      private static const BORDER_ROUND:int = 2;
       
      
      public var bgOverImage:Sprite = null;
      
      private var _bgBorder:Sprite;
      
      private var _isHoverState:Boolean = false;
      
      public function EntryPointBg()
      {
         this._bgBorder = new Sprite();
         super();
         addChild(this._bgBorder);
      }
      
      override protected function onDispose() : void
      {
         this.bgOverImage = null;
         this._bgBorder.graphics.clear();
         removeChild(this._bgBorder);
         this._bgBorder = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.bgOverImage.x = _width - this.bgOverImage.width >> 1;
            this.bgOverImage.y = _height - this.bgOverImage.height | 0;
            invalidateState();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.drawBg();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:Sprite = new Sprite();
         this.bgOverImage.addChild(_loc1_);
         this.bgOverImage.hitArea = _loc1_;
      }
      
      private function drawBg() : void
      {
         var _loc1_:Number = !!this._isHoverState ? Number(BG_ALPHA_HOVER) : Number(BG_ALPHA);
         var _loc2_:Number = !!this._isHoverState ? Number(BORDER_ALPHA_HOVER) : Number(BORDER_ALPHA);
         this._bgBorder.graphics.clear();
         this._bgBorder.graphics.lineStyle(1,BORDER_COLOR,_loc2_);
         this._bgBorder.graphics.beginFill(BG_COLOR,_loc1_);
         this._bgBorder.graphics.drawRoundRect(0,0,_width,_height,BORDER_ROUND,BORDER_ROUND);
         this._bgBorder.graphics.endFill();
         this._bgBorder.graphics.lineStyle(1,BORDER_COLOR,CORNER_ALPHA);
         this._bgBorder.graphics.moveTo(0,CORNER_SIZE);
         this._bgBorder.graphics.lineTo(0,0);
         this._bgBorder.graphics.lineTo(CORNER_SIZE,0);
         this._bgBorder.graphics.moveTo(_width - CORNER_SIZE,0);
         this._bgBorder.graphics.lineTo(_width,0);
         this._bgBorder.graphics.lineTo(_width,CORNER_SIZE);
         this._bgBorder.graphics.moveTo(_width,_height - CORNER_SIZE);
         this._bgBorder.graphics.lineTo(_width,_height);
         this._bgBorder.graphics.lineTo(_width - CORNER_SIZE,_height);
         this._bgBorder.graphics.moveTo(CORNER_SIZE,_height);
         this._bgBorder.graphics.lineTo(0,_height);
         this._bgBorder.graphics.lineTo(0,_height - CORNER_SIZE);
      }
      
      public function set isHoverState(param1:Boolean) : void
      {
         if(param1 != this._isHoverState)
         {
            this._isHoverState = param1;
            invalidateState();
         }
      }
   }
}
