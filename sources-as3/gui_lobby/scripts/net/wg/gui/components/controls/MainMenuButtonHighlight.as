package net.wg.gui.components.controls
{
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class MainMenuButtonHighlight extends UIComponentEx
   {
      
      private static const IMAGE_SMALL_POSTFIX = "_small";
      
      private static const PNG_EXT:String = ".png";
       
      
      private var _image:Image = null;
      
      private var _imageSource:String = "";
      
      private var _size:uint = 0;
      
      public function MainMenuButtonHighlight()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._image = new Image();
         this._image.addEventListener(Event.CHANGE,this.onImageChangeHandler,false,0,true);
         addChild(this._image);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE) || isInvalid(InvalidationType.DATA))
         {
            if(this._imageSource != Values.EMPTY_STR && this._size == MainMenuButtonSize.SMALL)
            {
               this._imageSource.replace(PNG_EXT,IMAGE_SMALL_POSTFIX + PNG_EXT);
            }
            this._image.source = this._imageSource;
         }
      }
      
      override protected function onDispose() : void
      {
         this._image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this._image.dispose();
         this._image = null;
         super.onDispose();
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         this._image.x = -this._image.width >> 1;
         this._image.y = -this._image.height >> 1;
      }
      
      public function set imageSource(param1:String) : void
      {
         if(this._imageSource != param1)
         {
            this._imageSource = param1;
            invalidateData();
         }
      }
      
      public function set imageSize(param1:uint) : void
      {
         if(this._size != param1)
         {
            this._size = param1;
            invalidateSize();
         }
      }
   }
}
