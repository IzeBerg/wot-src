package net.wg.gui.components.controls
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.interfaces.ISliderKeyPoint;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SliderKeyPoint extends UIComponentEx implements ISliderKeyPoint
   {
       
      
      public var labelTF:TextField = null;
      
      private var _clickable:Boolean = false;
      
      private var _tooltip:String = "";
      
      private var _availableTooltip:Boolean = false;
      
      private var _index:int = -1;
      
      private var _label:String = "";
      
      public function SliderKeyPoint()
      {
         super();
         buttonMode = useHandCursor = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         this.labelTF = null;
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         super.onDispose();
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
         this._availableTooltip = this._tooltip != null && this._tooltip != "";
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
         if(this.labelTF)
         {
            this.labelTF.htmlText = this._label;
         }
      }
      
      public function get clickable() : Boolean
      {
         return this._clickable;
      }
      
      public function set clickable(param1:Boolean) : void
      {
         if(this._clickable != param1)
         {
            this._clickable = param1;
            buttonMode = param1;
            useHandCursor = param1;
            mouseEnabled = param1;
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._availableTooltip)
         {
            App.toolTipMgr.show(this._tooltip);
         }
      }
   }
}
