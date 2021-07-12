package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class ButtonToggleIndicator extends UIComponentEx
   {
       
      
      public var hit:MovieClip;
      
      private var _selected:Boolean;
      
      public function ButtonToggleIndicator()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            gotoAndStop(!!this._selected ? 2 : 1);
         }
      }
      
      override protected function initialize() : void
      {
         _labelHash = UIComponent.generateLabelHash(this);
         _originalWidth = this.hit.width / super.scaleX;
         _originalHeight = this.hit.height / super.scaleY;
         if(_width == 0)
         {
            _width = this.hit.width;
         }
         if(_height == 0)
         {
            _height = this.hit.height;
         }
         invalidate();
      }
      
      override public function set scaleX(param1:Number) : void
      {
         super.scaleX = param1;
         if(rotation == 0)
         {
            width = this.hit.width;
         }
      }
      
      override public function set scaleY(param1:Number) : void
      {
         super.scaleY = param1;
         if(rotation == 0)
         {
            height = this.hit.height;
         }
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected != param1)
         {
            this._selected = param1;
            invalidateData();
         }
      }
      
      override protected function onDispose() : void
      {
         this.hit = null;
         super.onDispose();
      }
   }
}
