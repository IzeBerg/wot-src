package net.wg.gui.lobby.rankedBattles19.components.divisionProgress
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.BlockViewParams;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionProgressBlockVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class DivisionProgressRankRenderer extends UIComponentEx
   {
      
      private static var _blackWhiteFilters:Array = null;
      
      private static const LABEL_OFFSET:int = -30;
      
      private static const SHADOW_OFFSET_Y_SMALL:int = -10;
      
      private static const SHADOW_SHIELD_OFFSET_Y:int = 10;
      
      private static const ALPHA_STATE_SMALL:Number = 0.6;
      
      private static const ALPHA_STATE_BIG:Number = 0.8;
      
      private static const ALPHA_STATE_BIG_AQUIRED:Number = 1;
       
      
      public var image:Image = null;
      
      public var shieldView:DivisionRankShield = null;
      
      public var shadowMc:MovieClip = null;
      
      public var labelMc:MovieClip = null;
      
      private var _labelTF:TextField = null;
      
      private var _data:DivisionProgressBlockVO = null;
      
      private var _blockSize:Number = -1;
      
      private var _blockAlpha:Number = -1;
      
      private var _bigImageSource:String = "";
      
      private var _blockParams:BlockViewParams = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _alphaBigValue:Number = 0;
      
      private var _isActive:Boolean = false;
      
      public function DivisionProgressRankRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.cacheAsBitmap = true;
         this._toolTipMgr = App.toolTipMgr;
         this._labelTF = this.labelMc.labelTF;
         this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.shieldView.addEventListener(Event.RESIZE,this.onShieldResizeHandler);
         this.shadowMc.mouseEnabled = false;
         addEventListener(MouseEvent.ROLL_OVER,this.onRankMouseRollOverHandler,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onRankMouseRollOutHandler,true);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRankMouseRollOverHandler,true);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRankMouseRollOutHandler,true);
         this.image.filters = null;
         this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.image.dispose();
         this.image = null;
         this.shieldView.removeEventListener(Event.RESIZE,this.onShieldResizeHandler);
         this.shieldView.dispose();
         this.shieldView = null;
         this.shadowMc = null;
         this.labelMc = null;
         this._labelTF = null;
         this._data = null;
         this._blockParams = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data)
         {
            if(InvalidationType.DATA)
            {
               if(this._data.isAcquired)
               {
                  this.image.filters = null;
               }
               else if(_blackWhiteFilters)
               {
                  this.image.filters = _blackWhiteFilters;
               }
               else
               {
                  App.utils.commons.setSaturation(this.image,0);
                  _blackWhiteFilters = this.image.filters;
               }
               this._labelTF.text = this._data.rankLabel;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               if(this._blockParams == BlockViewParams.HUGE)
               {
                  this._bigImageSource = this._data.hugeImageSrc;
               }
               else
               {
                  this._bigImageSource = this._data.bigImageSrc;
               }
               this.updateState();
               if(this.shieldView.visible)
               {
                  this.labelMc.y = -(this.shieldView.actualHeight >> 1) + LABEL_OFFSET | 0;
               }
               else
               {
                  this.labelMc.y = -(this.image.height >> 1) + LABEL_OFFSET | 0;
               }
               this.shadowMc.y = this._blockParams == BlockViewParams.HUGE ? Number(0) : Number(SHADOW_OFFSET_Y_SMALL);
               if(this.shieldView.visible)
               {
                  this.shadowMc.y += SHADOW_SHIELD_OFFSET_Y;
               }
            }
         }
      }
      
      public function setData(param1:DivisionProgressBlockVO) : void
      {
         this._bigImageSource = Values.EMPTY_STR;
         this._blockSize = Values.DEFAULT_INT;
         this._blockAlpha = Values.DEFAULT_INT;
         this._data = param1;
         if(this._data)
         {
            this._alphaBigValue = !!param1.isAcquired ? Number(ALPHA_STATE_BIG_AQUIRED) : Number(ALPHA_STATE_BIG);
            this.shieldView.setData(this._data.shield);
            this.shieldView.visible = this._data.shield != null;
            invalidateData();
         }
      }
      
      public function setState(param1:Number, param2:Number, param3:Boolean) : void
      {
         this._isActive = param3;
         param1 = Math.min(1,Math.max(0,param1));
         param2 = Math.min(1,Math.max(0,param2));
         if(this._blockSize == param1 && this._blockAlpha == param2)
         {
            return;
         }
         this._blockSize = param1;
         this._blockAlpha = param2;
         if(this._data && this._data.shield)
         {
            this.shieldView.blockSize = param1;
         }
         invalidateSize();
      }
      
      private function updateState() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._blockSize == 0)
         {
            this.labelMc.alpha = 0;
            this.image.source = this._data.smallImageSrc;
            this.image.scaleX = this._blockParams.smallRank.scaleX;
            this.image.scaleY = this._blockParams.smallRank.scaleY;
            this.shadowMc.visible = false;
         }
         else if(this._blockSize < 1)
         {
            this.labelMc.alpha = this._blockSize;
            this.image.source = this._bigImageSource;
            _loc2_ = this._blockParams.scaleXCoeff;
            _loc3_ = this._blockParams.scaleYCoeff;
            this.image.scaleX = _loc2_ + (1 - _loc2_) * this._blockSize;
            this.image.scaleY = _loc3_ + (1 - _loc3_) * this._blockSize;
            this.shadowMc.visible = true;
            this.shadowMc.alpha = this._blockSize;
            _loc2_ = this._blockParams.smallShadow.actualWidth / this._blockParams.bigShadow.actualWidth;
            _loc3_ = this._blockParams.smallShadow.actualHeight / this._blockParams.bigShadow.actualHeight;
            this.shadowMc.scaleX = this._blockParams.bigShadow.scaleX * (_loc2_ + (1 - _loc2_) * this._blockSize);
            this.shadowMc.scaleY = this._blockParams.bigShadow.scaleY * (_loc3_ + (1 - _loc3_) * this._blockSize);
         }
         else
         {
            this.labelMc.alpha = 1;
            this.image.source = this._bigImageSource;
            this.image.scaleX = this._blockParams.bigRank.scaleX;
            this.image.scaleY = this._blockParams.bigRank.scaleY;
            this.shadowMc.visible = true;
            this.shadowMc.alpha = 1;
            this.shadowMc.scaleX = this._blockParams.bigShadow.scaleX;
            this.shadowMc.scaleY = this._blockParams.bigShadow.scaleY;
         }
         this.image.x = -(this.image.width >> 1);
         this.image.y = -(this.image.height >> 1);
         var _loc1_:Number = (this._alphaBigValue - ALPHA_STATE_SMALL) * this._blockSize;
         this.alpha = this._blockAlpha * (ALPHA_STATE_SMALL + _loc1_);
      }
      
      public function get data() : DivisionProgressBlockVO
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
         this.shieldView.blockParams = param1;
         invalidateSize();
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onShieldResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onRankMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onRankMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(this._isActive && this._data && this._data.hasTooltip)
         {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_RANK,null,this._data.rankID);
         }
      }
   }
}
