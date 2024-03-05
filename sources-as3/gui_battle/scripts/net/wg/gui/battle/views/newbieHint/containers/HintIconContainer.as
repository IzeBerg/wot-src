package net.wg.gui.battle.views.newbieHint.containers
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   
   public class HintIconContainer extends HintComponentContainer
   {
       
      
      public var icon:UILoaderAlt = null;
      
      private var _visibleWidth:int = 0;
      
      private var _visibleHeight:int = 0;
      
      private var _iconWidth:int = 0;
      
      private var _iconHeight:int = 0;
      
      private var _isLoaded:Boolean = false;
      
      public function HintIconContainer()
      {
         super();
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler,false,0,true);
      }
      
      override public function dispose() : void
      {
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.dispose();
         this.icon = null;
         super.dispose();
      }
      
      public function clear() : void
      {
         this._isLoaded = false;
         this.icon.unload();
      }
      
      public function setHintData(param1:String) : void
      {
         if(this.icon.source != param1)
         {
            this._isLoaded = false;
            this.icon.scrollRect = null;
            this.icon.source = param1;
         }
      }
      
      public function setVisibleArea(param1:int, param2:int) : void
      {
         this._visibleWidth = param1;
         this._visibleHeight = param2;
         this.updateVisibleArea();
      }
      
      private function updateVisibleArea() : void
      {
         if(this._isLoaded)
         {
            this.icon.scrollRect = new Rectangle(this._iconWidth - this._visibleWidth >> 1,this._iconHeight - this._visibleHeight >> 1,this._visibleWidth,this._visibleHeight);
         }
      }
      
      override protected function get content() : DisplayObject
      {
         return this.icon;
      }
      
      private function onIconCompleteHandler(param1:UILoaderEvent = null) : void
      {
         this._isLoaded = true;
         this._iconWidth = this.icon.width;
         this._iconHeight = this.icon.height;
         updateOffset();
         this.updateVisibleArea();
      }
   }
}
