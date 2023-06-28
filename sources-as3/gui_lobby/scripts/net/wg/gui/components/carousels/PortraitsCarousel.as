package net.wg.gui.components.carousels
{
   import flash.display.MovieClip;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class PortraitsCarousel extends CarouselBase
   {
       
      
      public var carouselBG:MovieClip;
      
      private var _buttonGroup:ButtonGroup;
      
      public function PortraitsCarousel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._buttonGroup.dispose();
         this._buttonGroup = null;
         this.carouselBG = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         leftArrow.soundEnabled = true;
         rightArrow.soundEnabled = true;
         this._buttonGroup = ButtonGroup.getGroup("portraitGroup",this);
      }
      
      override protected function initPosition() : void
      {
         super.initPosition();
         if(this.carouselBG)
         {
            this.carouselBG.x = renderersMask.x;
            this.carouselBG.y = renderersMask.y;
            this.carouselBG.width = renderersMask.width;
            this.carouselBG.height = renderersMask.height + 1;
         }
      }
      
      override protected function updateRenderPosition(param1:IListItemRenderer, param2:uint, param3:int, param4:Number) : void
      {
         super.updateRenderPosition(param1,param2,param3,param4);
         if(!this._buttonGroup.hasButton(Button(param1)))
         {
            this._buttonGroup.addButton(Button(param1));
         }
      }
   }
}
