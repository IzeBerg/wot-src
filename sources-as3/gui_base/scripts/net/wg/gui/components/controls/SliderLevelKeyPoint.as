package net.wg.gui.components.controls
{
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.interfaces.ISliderKeyPoint;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SliderLevelKeyPoint extends UIComponentEx implements ISliderKeyPoint
   {
       
      
      private var _clickable:Boolean = false;
      
      private var _availableTooltip:Boolean = false;
      
      private var _tooltip:String = "";
      
      private var _level:int = -1;
      
      private var _index:int = -1;
      
      public function SliderLevelKeyPoint()
      {
         super();
         stop();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
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
         return this._level.toString();
      }
      
      public function set label(param1:String) : void
      {
         this._level = parseInt(param1);
         gotoAndStop(this._level);
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
      
      private function onRollOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         if(this._availableTooltip)
         {
            App.toolTipMgr.show(this._tooltip);
         }
      }
   }
}
