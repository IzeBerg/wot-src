package net.wg.gui.battle.commander.views.common
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   
   public class HoverIcon extends BaseIcon
   {
      
      public static const BRACKETS_IN:String = "IN";
      
      public static const BRACKETS_OUT:String = "OUT";
      
      private static const INVALID_POSITION:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INVALID_RANGE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
       
      
      public var inner:MovieClip = null;
      
      public var outter:MovieClip = null;
      
      protected var _range:Number = 0.0;
      
      private var _currentType:String = "OUT";
      
      private var _hovered:Boolean = false;
      
      private var _selected:Boolean = false;
      
      private var _attachedMC:MovieClip = null;
      
      private var _isSupply:Boolean = false;
      
      public function HoverIcon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._attachedMC = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            visible = isShown && isAlive && (this._hovered || this._selected);
            if(visible)
            {
               this.setAlpha(!!this._selected ? Number(1) : Number(0.5));
            }
         }
         if(isInvalid(INVALID_POSITION))
         {
            if(this._attachedMC)
            {
               if(this._isSupply)
               {
                  this.moveTo(this._attachedMC.x,this.y);
               }
               else
               {
                  this.moveTo(this._attachedMC.x,this._attachedMC.y + this._attachedMC.height / 2);
               }
            }
         }
         if(isInvalid(INVALID_RANGE))
         {
            if(this._attachedMC)
            {
               this.setBracketsPos(this._range * -1,this._range);
            }
         }
      }
      
      public function attach(param1:MovieClip) : void
      {
         this._attachedMC = param1;
         invalidate(INVALID_POSITION);
      }
      
      private function setAlpha(param1:Number) : void
      {
         this.inner.alpha = param1;
         this.outter.alpha = param1;
      }
      
      private function moveTo(param1:Number, param2:Number) : void
      {
         x = param1;
         y = param2;
      }
      
      private function setBracketsPos(param1:Number, param2:Number) : void
      {
         if(this._currentType == BRACKETS_IN)
         {
            this.inner.x = param1 - this.inner.width / 2;
            this.outter.x = param2 + this.inner.width / 2;
         }
         else
         {
            this.outter.x = param1;
            this.inner.x = param2;
         }
      }
      
      public function set range(param1:Number) : void
      {
         if(this._range != param1)
         {
            this._range = param1 / 2;
            invalidate(INVALID_RANGE);
         }
      }
      
      public function set type(param1:String) : void
      {
         if(this._currentType != param1 && (param1 == BRACKETS_OUT || param1 == BRACKETS_IN))
         {
            this._currentType = param1;
            invalidate(INVALID_RANGE);
         }
      }
      
      public function set hovered(param1:Boolean) : void
      {
         if(this._hovered != param1)
         {
            this._hovered = param1;
            invalidateData();
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected != param1)
         {
            this._selected = param1;
            invalidateData();
         }
      }
      
      public function set isSupply(param1:Boolean) : void
      {
         if(this._isSupply != param1)
         {
            this._isSupply = param1;
            invalidate(INVALID_POSITION);
         }
      }
   }
}
