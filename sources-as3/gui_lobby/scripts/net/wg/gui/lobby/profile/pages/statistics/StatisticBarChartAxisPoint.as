package net.wg.gui.lobby.profile.pages.statistics
{
   import flash.display.Scene;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.managers.impl.ToolTipParams;
   import net.wg.gui.lobby.profile.components.SimpleLoader;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class StatisticBarChartAxisPoint extends SimpleLoader implements IListItemRenderer
   {
       
      
      protected var _data:StatisticChartInfo;
      
      private var _tooltip:String = null;
      
      private var _initialized:Boolean;
      
      public function StatisticBarChartAxisPoint()
      {
         super();
      }
      
      private static function mouseRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function onLoadingComplete() : void
      {
         this._initialized = true;
         super.onLoadingComplete();
      }
      
      override protected function onDispose() : void
      {
         this.disposeHandlers();
         this._data = null;
         super.onDispose();
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
      }
      
      public function gotoAndStop(param1:Object, param2:String = null) : void
      {
      }
      
      public function nextFrame() : void
      {
      }
      
      public function nextScene() : void
      {
      }
      
      public function play() : void
      {
      }
      
      public function prevFrame() : void
      {
      }
      
      public function prevScene() : void
      {
      }
      
      public function setData(param1:Object) : void
      {
         this._data = StatisticChartInfo(param1);
         this.tooltip = this._data.tooltip;
         var _loc2_:Number = 0.27;
         alpha = this._data.yField == -1 ? Number(_loc2_) : Number(1);
         setSource(this._data.icon);
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      public function stop() : void
      {
      }
      
      protected function showToolTip() : void
      {
         var _loc1_:Object = null;
         if(this.tooltip)
         {
            _loc1_ = {};
            if(this._data != null)
            {
               _loc1_.value = this._data.xField;
            }
            App.toolTipMgr.showComplexWithParams(this.tooltip,new ToolTipParams(_loc1_,{}));
         }
      }
      
      private function disposeHandlers() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,mouseRollOutHandler);
      }
      
      public function get UIID() : uint
      {
         return 0;
      }
      
      public function set UIID(param1:uint) : void
      {
      }
      
      public function get currentFrame() : int
      {
         return 0;
      }
      
      public function get framesLoaded() : int
      {
         return 0;
      }
      
      public function get totalFrames() : int
      {
         return 0;
      }
      
      public function get trackAsMenu() : Boolean
      {
         return false;
      }
      
      public function set trackAsMenu(param1:Boolean) : void
      {
      }
      
      public function get scenes() : Array
      {
         return null;
      }
      
      public function get currentScene() : Scene
      {
         return null;
      }
      
      public function get currentFrameLabel() : String
      {
         return "";
      }
      
      public function get currentLabels() : Array
      {
         return null;
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
         this.disposeHandlers();
         if(this._tooltip)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,mouseRollOutHandler,false,0,true);
         }
      }
      
      public function get index() : uint
      {
         return 0;
      }
      
      public function set index(param1:uint) : void
      {
      }
      
      public function get owner() : UIComponent
      {
         return null;
      }
      
      public function set owner(param1:UIComponent) : void
      {
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function get displayFocus() : Boolean
      {
         return false;
      }
      
      public function set displayFocus(param1:Boolean) : void
      {
      }
      
      public function get enabled() : Boolean
      {
         return false;
      }
      
      public function set enabled(param1:Boolean) : void
      {
      }
      
      public function get focusTarget() : UIComponent
      {
         return null;
      }
      
      public function set focusTarget(param1:UIComponent) : void
      {
      }
      
      public function get initialized() : Boolean
      {
         return this._initialized;
      }
      
      public function validateNow(param1:Event = null) : void
      {
      }
      
      public function handleInput(param1:InputEvent) : void
      {
      }
      
      protected function mouseRollOverHandler(param1:MouseEvent) : void
      {
         this.showToolTip();
      }
   }
}
