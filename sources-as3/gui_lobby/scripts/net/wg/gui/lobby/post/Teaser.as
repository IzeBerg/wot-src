package net.wg.gui.lobby.post
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.post.data.TeaserVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.utils.ICommons;
   import net.wg.utils.ICounterManager;
   import scaleform.clik.constants.InvalidationType;
   
   public class Teaser extends UIComponentEx implements ISoundable
   {
      
      private static const VIDEO:String = "video";
      
      private static const VERSION_PROMO:String = "versionPromo";
      
      private static const SHOP:String = "shop";
      
      private static const CONTENT_PROMO:String = "contentPromo";
      
      private static const IMG_BIG_HEIGHT:Number = 160;
      
      private static const SMALL_TEASER_POSTFIX:String = "_small";
      
      private static const IMGRECT_TEASERSMALL:Rectangle = new Rectangle(143,35,190,128);
      
      private static const IMGRECT_TEASERNORMAL:Rectangle = new Rectangle(144,38,190,128);
      
      private static const IMGRECT_TEASERNORMAL_BIG:Rectangle = new Rectangle(120,38,238,160);
      
      private static const IMG_DEFAULT_POS:Number = 2;
      
      private static const DOTS:String = "...";
      
      private static const MAX_LINES:int = 2;
      
      public static const STAGE_WIDTH_BOUNDARY:int = 1680;
      
      public static const MASK_WIDTH:int = 475;
      
      public static const MASK_WIDTH_SMALL:int = 229;
      
      public static const MASK_X:int = 2;
      
      public static const MASK_X_SMALL:int = 124;
      
      public static const TITLE_PADDING_BOTTOM:int = 14;
      
      public static const TITLE_PADDING_BOTTOM_SMALL:int = 45;
       
      
      public var closeBtn:ISoundButtonEx = null;
      
      public var image:UILoaderAlt = null;
      
      public var postTitle:TextField = null;
      
      public var title:TextField = null;
      
      public var timer:TextField = null;
      
      public var middleTitle:TextField = null;
      
      public var teaserMask:Sprite = null;
      
      public var hitMc:Sprite = null;
      
      public var timerGlow:Sprite = null;
      
      public var hover:Sprite = null;
      
      public var over:Sprite = null;
      
      public var back:Sprite = null;
      
      private var _data:TeaserVO = null;
      
      private var _counterManager:ICounterManager;
      
      private var _commons:ICommons;
      
      private var _soundMgr:ISoundManager;
      
      private var _stateName:String;
      
      private var _currentState:String;
      
      private var _timeLabel:String = "";
      
      private var _soundType:String = "normal";
      
      private var _soundId:String = "";
      
      private var _isImageLoaded:Boolean = false;
      
      public function Teaser()
      {
         this._counterManager = App.utils.counterManager;
         this._commons = App.utils.commons;
         this._soundMgr = App.soundMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._stateName = VERSION_PROMO;
         alpha = 0;
         this.hitMc.buttonMode = true;
         this.hitMc.mouseChildren = false;
         this.hover.visible = false;
         this.timerGlow.visible = false;
         this.image.mouseEnabled = false;
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.hitMc.addEventListener(MouseEvent.CLICK,this.onHitMcClickHandler);
         this.closeBtn.addEventListener(MouseEvent.CLICK,this.onCloseBtnClickHandler);
         this.image.addEventListener(UILoaderEvent.COMPLETE,this.onImageCompleteHandler);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.hover.visible = true;
         this._soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.ITEM_RDR,null);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.hover.visible = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this.stage == null)
         {
            return;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.setState(this._stateName);
         }
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.back.visible = false;
            this.over.visible = true;
            if(this._data.isVideo)
            {
               this.setState(VIDEO);
            }
            else if(this._data.isShopPromo)
            {
               this.setState(SHOP);
               this.back.visible = true;
               this.over.visible = false;
            }
            else if(this._data.title != Values.EMPTY_STR)
            {
               this.setState(VERSION_PROMO);
            }
            else
            {
               this.setState(CONTENT_PROMO);
            }
            this.image.autoSize = false;
            this.image.source = this._data.image;
            this.postTitle.text = this._data.postTitle;
            this._commons.updateTextFieldSize(this.postTitle);
            if(this._data.postCounter > 0)
            {
               this._counterManager.setCounter(this.postTitle,this._data.postCounter.toString());
            }
            this.timerGlow.visible = this._timeLabel != Values.EMPTY_STR;
            App.utils.commons.truncateTextFieldMultiline(this.title,this._data.descr,MAX_LINES,DOTS);
            this._commons.updateTextFieldSize(this.title,false,true);
            _loc1_ = this.stage.stageWidth <= STAGE_WIDTH_BOUNDARY && this.timerGlow.visible ? int(TITLE_PADDING_BOTTOM_SMALL) : int(TITLE_PADDING_BOTTOM);
            this.title.y = height - this.title.height - _loc1_;
            this.middleTitle.text = this._data.title;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.hitMc.removeEventListener(MouseEvent.CLICK,this.onHitMcClickHandler);
         this.closeBtn.removeEventListener(MouseEvent.CLICK,this.onCloseBtnClickHandler);
         this.image.removeEventListener(UILoaderEvent.COMPLETE,this.onImageCompleteHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._counterManager.removeCounter(this.postTitle);
         this._counterManager = null;
         this._commons = null;
         this._soundMgr = null;
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.image.dispose();
         this.image = null;
         this.teaserMask = null;
         this.hitMc = null;
         this.timerGlow = null;
         this.postTitle = null;
         this.title = null;
         this.timer = null;
         this.over = null;
         this.back = null;
         this.middleTitle = null;
         this.hover = null;
         this._data = null;
         super.onDispose();
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return true;
      }
      
      public function drawToBitmap() : Bitmap
      {
         var _loc1_:Rectangle = this.over.getBounds(this);
         var _loc2_:Point = localToGlobal(new Point(_loc1_.x,_loc1_.y));
         var _loc3_:Matrix = new Matrix();
         _loc3_.translate(-_loc1_.x,-_loc1_.y);
         var _loc4_:BitmapData = new BitmapData(_loc1_.width,_loc1_.height,true,0);
         _loc4_.draw(this,_loc3_);
         var _loc5_:Bitmap = new Bitmap(_loc4_);
         _loc5_.x = _loc2_.x;
         _loc5_.y = _loc2_.y;
         return _loc5_;
      }
      
      public function getSoundId() : String
      {
         return this._soundId;
      }
      
      public function getSoundType() : String
      {
         return this._soundType;
      }
      
      public function hideTimer() : void
      {
         this.timer.visible = false;
         this.timerGlow.visible = false;
         this._timeLabel = Values.EMPTY_STR;
         this.title.y = height - this.title.height - TITLE_PADDING_BOTTOM;
      }
      
      public function setData(param1:TeaserVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function setTime(param1:String) : void
      {
         this.timer.visible = true;
         this.timerGlow.visible = param1 != Values.EMPTY_STR;
         this._timeLabel = param1;
         this.timer.htmlText = param1;
      }
      
      override public function get stage() : Stage
      {
         return App.stage;
      }
      
      private function clean() : void
      {
         this.title.text = Values.EMPTY_STR;
         this.middleTitle.text = Values.EMPTY_STR;
         this._counterManager.removeCounter(this.postTitle);
         this.postTitle.text = Values.EMPTY_STR;
         this.timer.htmlText = this._timeLabel;
      }
      
      private function setState(param1:String) : void
      {
         var _loc2_:String = null;
         if(this.stage.stageWidth <= STAGE_WIDTH_BOUNDARY)
         {
            _loc2_ = param1 + SMALL_TEASER_POSTFIX;
            this.teaserMask.width = MASK_WIDTH_SMALL;
            this.teaserMask.x = MASK_X_SMALL;
         }
         else
         {
            _loc2_ = param1;
            this.teaserMask.width = MASK_WIDTH;
            this.teaserMask.x = MASK_X;
         }
         if(_loc2_ != this._currentState)
         {
            this.clean();
            this._currentState = _loc2_;
            this._stateName = param1;
            gotoAndStop(_loc2_);
            this.hover.visible = false;
            this.resizeImage();
            invalidateData();
         }
      }
      
      private function get isStateSmall() : Boolean
      {
         return this._stateName + SMALL_TEASER_POSTFIX == this._currentState;
      }
      
      private function resizeImage() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Rectangle = null;
         var _loc4_:Number = NaN;
         if(!this._isImageLoaded)
         {
            return;
         }
         if(this._data.isShopPromo)
         {
            _loc1_ = 1;
            _loc2_ = 1;
            _loc3_ = IMGRECT_TEASERSMALL;
            if(this.isStateSmall)
            {
               _loc3_ = IMGRECT_TEASERSMALL;
            }
            else if(this.image.height < IMG_BIG_HEIGHT)
            {
               _loc3_ = IMGRECT_TEASERNORMAL;
            }
            else
            {
               _loc3_ = IMGRECT_TEASERNORMAL_BIG;
            }
            if(_loc3_.width < this.image.width)
            {
               _loc1_ = _loc3_.width / this.image.width;
            }
            if(_loc3_.height < this.image.height)
            {
               _loc2_ = _loc3_.height / this.image.height;
            }
            if(this.isStateSmall)
            {
               _loc4_ = Math.min(_loc1_,_loc2_);
            }
            else
            {
               _loc4_ = Math.max(_loc1_,_loc2_);
            }
            this.image.scaleX = this.image.scaleY = _loc4_;
            this.image.x = _loc3_.x + (_loc3_.width >> 1) - (this.image.width >> 1);
            this.image.y = _loc3_.y;
         }
         else
         {
            this.image.x = IMG_DEFAULT_POS;
            this.image.y = IMG_DEFAULT_POS;
         }
      }
      
      private function onImageCompleteHandler(param1:UILoaderEvent) : void
      {
         this._isImageLoaded = true;
         this.resizeImage();
      }
      
      private function onHitMcClickHandler(param1:MouseEvent) : void
      {
         if(this._commons.isLeftButton(param1))
         {
            dispatchEvent(new TeaserEvent(TeaserEvent.TEASER_CLICK));
            this._soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.ITEM_RDR,null);
         }
      }
      
      private function onCloseBtnClickHandler(param1:MouseEvent) : void
      {
         if(this._commons.isLeftButton(param1))
         {
            dispatchEvent(new TeaserEvent(TeaserEvent.HIDE,true));
         }
      }
   }
}
