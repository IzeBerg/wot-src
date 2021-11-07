package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.events.Event;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import scaleform.clik.constants.InvalidationType;
   
   public class CarouselRendererAttachedBase extends UIComponentEx implements IDropItem
   {
       
      
      public var imgIcon:Image = null;
      
      private var _dataVO:CustomizationCarouselRendererVO = null;
      
      private var _isAllSeasons:Boolean = false;
      
      public function CarouselRendererAttachedBase()
      {
         super();
      }
      
      private static function toggleCache(param1:Image, param2:Boolean) : void
      {
         param1.cacheType = !!param2 ? int(ImageCacheTypes.USE_WEB_CACHE) : int(ImageCacheTypes.NOT_USE_CACHE);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.imgIcon.addEventListener(Event.CHANGE,this.onImgIconChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.imgIcon.removeEventListener(Event.CHANGE,this.onImgIconChangeHandler);
         this.imgIcon.dispose();
         this.imgIcon = null;
         this._dataVO = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._dataVO != null && isInvalid(InvalidationType.DATA))
         {
            toggleCache(this.imgIcon,this._dataVO.imageCached);
            this.imgIcon.source = this._dataVO.icon;
         }
      }
      
      public function setData(param1:CustomizationCarouselRendererVO) : void
      {
         this._dataVO = param1;
         this._isAllSeasons = param1.isAllSeasons;
         invalidateData();
      }
      
      protected function setImageIconTransform() : void
      {
      }
      
      public function get getCursorType() : String
      {
         return Cursors.HAND;
      }
      
      public function get data() : Object
      {
         return this._dataVO;
      }
      
      public function getIsAllSeasons() : Boolean
      {
         return this._isAllSeasons;
      }
      
      private function onImgIconChangeHandler(param1:Event) : void
      {
         this.setImageIconTransform();
      }
   }
}
