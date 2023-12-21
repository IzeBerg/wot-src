package net.wg.gui.components.common.counters
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class CounterView extends UIComponentEx
   {
       
      
      public var label:TextField = null;
      
      public var back:Sprite = null;
      
      public var hitMc:Sprite = null;
      
      private var _originalBackWidth:int = 0;
      
      private var _tfPadding:int = 0;
      
      public function CounterView()
      {
         super();
         this._originalBackWidth = this.back.width;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hitMc;
         this.back.mouseEnabled = false;
         this.back.mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.label = null;
         this.back = null;
         this.hitMc = null;
         super.onDispose();
      }
      
      public function setCount(param1:String) : void
      {
         var _loc2_:int = 0;
         if(this.label != null && this.label.htmlText != param1)
         {
            this.label.htmlText = param1;
            App.utils.commons.updateTextFieldSize(this.label);
            _loc2_ = this.label.width + (this._tfPadding << 1);
            this.back.width = _loc2_ < this._originalBackWidth ? Number(this._originalBackWidth) : Number(_loc2_);
            this.label.x = this.back.x + this._tfPadding + (this.back.width - _loc2_ >> 1) | 0;
         }
      }
      
      public function get tfPadding() : int
      {
         return this._tfPadding;
      }
      
      public function set tfPadding(param1:int) : void
      {
         this._tfPadding = param1;
      }
   }
}
