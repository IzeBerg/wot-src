package net.wg.gui.lobby.header.headerButtonBar
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   
   public class HBC_Upper extends HeaderButtonContentItem
   {
      
      private static const ICON_WIDTH_DEFAULT:int = 48;
       
      
      public var upperBg:UILoaderAlt = null;
      
      public var upperIcon:UILoaderAlt = null;
      
      private var _needUpdateSize:Boolean = false;
      
      private var _iconsLoaded:int = 0;
      
      private var _iconsForLoad:int = 0;
      
      public function HBC_Upper()
      {
         super();
      }
      
      protected function loadAssets(param1:String, param2:String) : void
      {
         this._iconsForLoad = 0;
         this._iconsLoaded = 0;
         if(param1 != this.upperBg.source)
         {
            ++this._iconsForLoad;
            this.upperBg.source = param1;
            this.upperBg.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadedHandler);
         }
         if(param2 != this.upperIcon.source)
         {
            ++this._iconsForLoad;
            this.upperIcon.source = param2;
            this.upperIcon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadedHandler);
         }
      }
      
      override public function setAvailableWidth(param1:Number) : void
      {
         availableWidth = param1;
         if(availableWidth > 0)
         {
            this.updateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.upperBg.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadedHandler);
         this.upperIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadedHandler);
         this.upperBg.dispose();
         this.upperBg = null;
         this.upperIcon.dispose();
         this.upperIcon = null;
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._iconsLoaded >= this._iconsForLoad)
         {
            this.upperBg.width = availableWidth;
            _loc1_ = this.upperIcon.width;
            _loc2_ = _loc1_ > ICON_WIDTH_DEFAULT ? int(_loc1_ - ICON_WIDTH_DEFAULT) : int(0);
            this.upperIcon.x = availableWidth - _loc1_ + _loc2_ >> 1;
            this.upperIcon.y = this.upperBg.height - (this.upperIcon.height >> 1);
         }
         else
         {
            this._needUpdateSize = true;
         }
      }
      
      private function onIconLoadedHandler(param1:UILoaderEvent) : void
      {
         param1.target.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadedHandler);
         ++this._iconsLoaded;
         if(this._iconsLoaded >= this._iconsForLoad && this._needUpdateSize)
         {
            this.updateSize();
         }
      }
   }
}
