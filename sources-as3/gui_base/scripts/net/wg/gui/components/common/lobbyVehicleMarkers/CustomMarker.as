package net.wg.gui.components.common.lobbyVehicleMarkers
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomMarker extends UIComponentEx
   {
      
      private static const IMG_ICON_OFFSET_X:int = 12;
       
      
      public var imgIcon:Image = null;
      
      public var tf:TextField;
      
      private var _model:CustomMarkerVO = null;
      
      public function CustomMarker()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.imgIcon.cacheType = ImageCacheTypes.USE_WEB_CACHE;
         this.imgIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.imgIcon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.imgIcon.dispose();
         this.imgIcon = null;
         this.tf = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this.tf.text = this._model.text;
            App.utils.commons.updateTextFieldSize(this.tf);
            this.tf.x = -this.tf.width >> 1;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.imgIcon.x = this.tf.x - (this.imgIcon.width >> 1) - IMG_ICON_OFFSET_X;
            this.imgIcon.y = this.tf.height - this.imgIcon.height >> 1;
         }
      }
      
      public function setInfo(param1:String, param2:String) : void
      {
         this._model = new CustomMarkerVO();
         this._model.icon = param1;
         this._model.text = param2;
         this.imgIcon.source = this._model.icon;
         invalidateData();
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
