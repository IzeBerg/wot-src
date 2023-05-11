package net.wg.gui.lobby.rankedBattles19.components.divisionProgress
{
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.BlockViewParams;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionShieldVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class DivisionRankShield extends UIComponentEx
   {
      
      private static const PLATE_OFFSET_WIDTH_MULT:Number = 0.9;
      
      private static const PLATE_OFFSET_HEIGHT_MULT:Number = 0.1;
       
      
      public var shieldImage:Image = null;
      
      public var plateImage:Image = null;
      
      private var _data:DivisionShieldVO = null;
      
      private var _blockParams:BlockViewParams = null;
      
      private var _blockSize:Number = -1;
      
      private var _bigImageSource:String = "";
      
      private var _smallPlateImageSource:String = "";
      
      private var _bigPlateImageSource:String = "";
      
      public function DivisionRankShield()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         mouseChildren = false;
         this.shieldImage.addEventListener(Event.CHANGE,this.onShieldImageChangeHandler);
         this.plateImage.addEventListener(Event.CHANGE,this.onPlateImageChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.shieldImage.removeEventListener(Event.CHANGE,this.onShieldImageChangeHandler);
         this.shieldImage.dispose();
         this.shieldImage = null;
         this.plateImage.removeEventListener(Event.CHANGE,this.onPlateImageChangeHandler);
         this.plateImage.dispose();
         this.plateImage = null;
         this._blockParams = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.SIZE,InvalidationType.DATA))
         {
            if(this._blockParams == BlockViewParams.SMALL)
            {
               this._smallPlateImageSource = this._data.smallPlateSrc;
            }
            else
            {
               this._smallPlateImageSource = this._data.mediumPlateSrc;
            }
            if(this._blockParams == BlockViewParams.HUGE)
            {
               this._bigImageSource = this._data.hugeImageSrc;
               this._bigPlateImageSource = this._data.hugePlateSrc;
            }
            else
            {
               this._bigImageSource = this._data.bigImageSrc;
               this._bigPlateImageSource = this._data.bigPlateSrc;
            }
            this.updateState();
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      public function setData(param1:DivisionShieldVO) : void
      {
         this._bigImageSource = Values.EMPTY_STR;
         this._blockSize = -1;
         this._data = param1;
         if(this._data)
         {
            invalidateData();
         }
      }
      
      private function updateState() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this._data == null || this._blockParams == null)
         {
            return;
         }
         if(this._blockSize == 0)
         {
            this.shieldImage.source = this._data.smallImageSrc;
            this.plateImage.source = this._smallPlateImageSource;
            this.shieldImage.scaleX = this._blockParams.smallRank.scaleX;
            this.shieldImage.scaleY = this._blockParams.smallRank.scaleY;
            this.plateImage.scaleX = this._blockParams.smallPlate.scaleX;
            this.plateImage.scaleY = this._blockParams.smallPlate.scaleY;
         }
         else if(this._blockSize < 1)
         {
            this.shieldImage.source = this._bigImageSource;
            this.plateImage.source = this._bigPlateImageSource;
            _loc1_ = this._blockParams.scaleXCoeff;
            _loc2_ = this._blockParams.scaleYCoeff;
            this.shieldImage.scaleX = _loc1_ + (1 - _loc1_) * this._blockSize;
            this.shieldImage.scaleY = _loc2_ + (1 - _loc2_) * this._blockSize;
            _loc1_ = this._blockParams.smallPlate.actualWidth / this._blockParams.bigPlate.actualWidth;
            _loc2_ = this._blockParams.smallPlate.actualHeight / this._blockParams.bigPlate.actualHeight;
            this.plateImage.scaleX = this._blockParams.bigPlate.scaleX * (_loc1_ + (1 - _loc1_) * this._blockSize);
            this.plateImage.scaleY = this._blockParams.smallPlate.scaleY * (_loc2_ + (1 - _loc2_) * this._blockSize);
         }
         else
         {
            this.shieldImage.source = this._bigImageSource;
            this.plateImage.source = this._bigPlateImageSource;
            this.shieldImage.scaleX = this._blockParams.bigRank.scaleX;
            this.shieldImage.scaleY = this._blockParams.bigRank.scaleY;
            this.plateImage.scaleX = this._blockParams.bigPlate.scaleX;
            this.plateImage.scaleY = this._blockParams.bigPlate.scaleY;
         }
         this.shieldImage.x = -(this.shieldImage.width >> 1);
         this.shieldImage.y = -(this.shieldImage.height >> 1);
         this.plateImage.x = this.shieldImage.x + this.shieldImage.width - this.plateImage.width * PLATE_OFFSET_WIDTH_MULT | 0;
         this.plateImage.y = -(this.shieldImage.height >> 1) - this.plateImage.height * PLATE_OFFSET_HEIGHT_MULT | 0;
      }
      
      public function get data() : DivisionShieldVO
      {
         return this._data;
      }
      
      public function set blockParams(param1:BlockViewParams) : void
      {
         if(this._blockParams == param1)
         {
            return;
         }
         this._blockParams = param1;
         invalidateSize();
      }
      
      public function set blockSize(param1:Number) : void
      {
         param1 = Math.min(1,Math.max(0,param1));
         if(this._blockSize == param1)
         {
            return;
         }
         this._blockSize = param1;
         invalidateSize();
      }
      
      private function onShieldImageChangeHandler(param1:Event) : void
      {
         setSize(this.shieldImage.width,this.shieldImage.height);
      }
      
      private function onPlateImageChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
