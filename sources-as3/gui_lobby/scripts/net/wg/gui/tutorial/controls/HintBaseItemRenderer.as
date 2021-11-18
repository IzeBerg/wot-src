package net.wg.gui.tutorial.controls
{
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class HintBaseItemRenderer extends UIComponentEx
   {
       
      
      protected var _data:Object;
      
      public function HintBaseItemRenderer()
      {
         super();
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
         invalidate(InvalidationType.DATA);
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this.drawData();
         }
      }
      
      protected function drawData() : void
      {
      }
   }
}
