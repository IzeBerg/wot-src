package net.wg.gui.lobby.vehiclePreview.additionalInfo
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehicleInfoDesc extends UIComponentEx
   {
      
      private static const FLAG_WIDTH:uint = 20;
      
      private static const FLAG_PADDING_RIGHT:uint = 12;
      
      private static const IMG_WIDTH:uint = 24;
      
      private static const IMG_PADDING_LEFT:uint = 6;
      
      private static const IMG_PADDING_RIGHT:uint = 2;
      
      private static const IMG_Y:int = 2;
      
      private static const IMG_ELITE_Y:int = -2;
       
      
      public var nationFlag:Image = null;
      
      public var lvlTf:TextField = null;
      
      public var typeImg:Image = null;
      
      public var nameTf:TextField = null;
      
      private var _data:VehicleInfoDescVO = null;
      
      public function VehicleInfoDesc()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.nationFlag.mouseChildren = this.nationFlag.mouseEnabled = false;
         this.typeImg.mouseChildren = this.typeImg.mouseEnabled = false;
         this.lvlTf.autoSize = TextFieldAutoSize.LEFT;
         this.nameTf.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.nationFlag.source = this._data.nationFlag;
               this.lvlTf.text = this._data.level;
               this.typeImg.source = this._data.typeImageSrc;
               this.nameTf.text = this._data.name;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.lvlTf.x = this.nationFlag.x + FLAG_WIDTH + FLAG_PADDING_RIGHT | 0;
               this.typeImg.x = this.lvlTf.x + this.lvlTf.textWidth + IMG_PADDING_LEFT | 0;
               this.nameTf.x = this.typeImg.x + IMG_WIDTH + IMG_PADDING_RIGHT;
               this.typeImg.y = !!this._data.isElite ? Number(IMG_ELITE_Y) : Number(IMG_Y);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.nationFlag.dispose();
         this.nationFlag = null;
         this.lvlTf = null;
         this.typeImg.dispose();
         this.typeImg = null;
         this.nameTf = null;
         super.onDispose();
      }
      
      public function setData(param1:VehicleInfoDescVO) : void
      {
         this._data = param1;
         invalidateSize();
         invalidateData();
      }
   }
}
