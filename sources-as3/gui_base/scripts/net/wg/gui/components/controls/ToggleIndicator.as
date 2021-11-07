package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class ToggleIndicator extends UIComponentEx
   {
      
      private static const TOGGLE_ON:String = "on";
      
      private static const TOGGLE_OFF:String = "off";
       
      
      public var hit:MovieClip;
      
      private var _selected:Boolean;
      
      public function ToggleIndicator()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         _labelHash = UIComponent.generateLabelHash(this);
         setSize(this.hit.width,this.hit.height);
         invalidate();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = !!this._selected ? TOGGLE_ON : TOGGLE_OFF;
            App.utils.asserter.assert(_labelHash.hasOwnProperty(_loc1_),"Not found state " + _loc1_);
            gotoAndStop(_loc1_);
         }
      }
      
      override protected function onDispose() : void
      {
         this.hit = null;
         super.onDispose();
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
   }
}
