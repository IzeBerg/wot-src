package net.wg.gui.gameloading
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Locales;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.BaseLogoView;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.IGameLoading;
   import net.wg.infrastructure.base.meta.impl.GameLoadingMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.StatusIndicator;
   
   public class GameLoading extends GameLoadingMeta implements IGameLoading
   {
      
      private static const AWARDS_PATH:String = "../maps/loading_award.png";
      
      private static const INVALID_VERSION:String = "invalidVersion";
      
      private static const INVALID_PROGRESS:String = "invalidProgress";
      
      private static const INVALID_LOCALE:String = "invalidLocale";
      
      private static const INVALID_INFO:String = "invalidInfo";
      
      private static const FORM_VERTICAL_OFFSET:uint = 52;
      
      private static const INFO_TEXT_PADDING:uint = 20;
      
      private static const MAX_INFO_FONT_SIZE:uint = 64;
      
      private static const CHINA_AGE_RATING_OFFSET_X:uint = 30;
      
      private static const CHINA_AGE_RATING_OFFSET_Y:uint = 80;
      
      private static const INFO_TEXT_HEIGHT_CORRECTION:uint = 10;
      
      private static const INIT_COMPONENT_HALF_WIDTH:uint = StageSizeBoundaries.WIDTH_1920 >> 1;
      
      private static const INIT_COMPONENT_HALF_HEIGHT:uint = StageSizeBoundaries.HEIGHT_1080 >> 1;
       
      
      public var versionTF:TextField;
      
      public var background:UILoaderAlt;
      
      public var wotLogo:LoadingLogo;
      
      public var form:MovieClip;
      
      public var copyright:MovieClip;
      
      public var ageRating:BaseLogoView;
      
      private var _progressBar:StatusIndicator;
      
      private var _awardsLoader:UILoaderAlt;
      
      private var _infoTF:TextField;
      
      private var _bottomLogos:BaseLogoView;
      
      private var _initVersionTFPos:Point;
      
      private var _initCopyrightPos:Point;
      
      private var _initAgeRatingPos:Point;
      
      private var _appWidth:Number;
      
      private var _appHeight:Number;
      
      private var _scale:Number;
      
      private var _isLocaleSet:Boolean = false;
      
      private var _version:String;
      
      private var _info:String = "";
      
      private var _locale:String;
      
      private var _progress:Number;
      
      public function GameLoading()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._progressBar = this.form.progressBar;
         this._infoTF = this.form.infoTF;
         this._awardsLoader = this.copyright.awards;
         this._bottomLogos = this.copyright.logos;
         this._progressBar.maximum = 1;
         this.ageRating.visible = this._infoTF.visible = false;
         this._awardsLoader.visible = false;
         this._initVersionTFPos = new Point(this.versionTF.x,this.versionTF.y);
         this._initCopyrightPos = new Point(this.copyright.x,this.copyright.y);
         this._initAgeRatingPos = new Point(this.ageRating.x,this.ageRating.y);
         this._awardsLoader.addEventListener(UILoaderEvent.COMPLETE,this.onAwardsCompleteHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_VERSION))
         {
            this.versionTF.text = this._version;
         }
         if(isInvalid(INVALID_PROGRESS))
         {
            this._progressBar.position = this._progress;
         }
         if(this._isLocaleSet && isInvalid(INVALID_LOCALE))
         {
            if(this._locale)
            {
               this.ageRating.visible = this._locale == Locales.KOREA || this._locale == Locales.CHINA;
               this.ageRating.setLocale(this._locale);
               this._bottomLogos.setLocale(this._locale);
            }
            if(this._locale == Locales.KOREA)
            {
               this._infoTF.visible = true;
               this.copyright.removeChild(this._awardsLoader);
               invalidate(INVALID_INFO);
            }
            else
            {
               this._awardsLoader.visible = true;
               this._awardsLoader.source = AWARDS_PATH;
            }
         }
         if(isInvalid(INVALID_INFO))
         {
            this._infoTF.htmlText = this._info;
         }
         this._infoTF.visible = this._info != Values.EMPTY_STR;
         if(isInvalid(InvalidationType.SIZE) && !isNaN(this._appWidth) && !isNaN(this._appHeight))
         {
            this.relayout();
         }
      }
      
      override protected function onDispose() : void
      {
         this.background.dispose();
         this.background = null;
         this.wotLogo.dispose();
         this.wotLogo = null;
         this.ageRating.dispose();
         this.ageRating = null;
         this.versionTF = null;
         this.form = null;
         this.copyright = null;
         if(this._awardsLoader)
         {
            this._awardsLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onAwardsCompleteHandler);
            this._awardsLoader = null;
         }
         this._progressBar = null;
         this._bottomLogos = null;
         this._infoTF = null;
         this._initVersionTFPos = null;
         this._initCopyrightPos = null;
         this._initAgeRatingPos = null;
         super.onDispose();
      }
      
      public function as_setInfo(param1:String) : void
      {
         this._info = param1;
         invalidate(INVALID_INFO);
      }
      
      public function as_setLocale(param1:String) : void
      {
         this._locale = param1;
         this._isLocaleSet = true;
         invalidate(INVALID_LOCALE);
      }
      
      public function as_setProgress(param1:Number) : void
      {
         this._progress = param1;
         invalidate(INVALID_PROGRESS);
      }
      
      public function as_setVersion(param1:String) : void
      {
         this._version = param1;
         invalidate(INVALID_VERSION);
      }
      
      public function as_updateStage(param1:Number, param2:Number, param3:Number) : void
      {
         param2 = param2 / param3 >> 0;
         param1 = param1 / param3 >> 0;
         if(this._appWidth == param1 && this._appHeight == param2 && param3 == this._scale)
         {
            return;
         }
         stage.scaleX = stage.scaleY = param3;
         this._scale = param3;
         this._appWidth = param1;
         this._appHeight = param2;
         invalidateSize();
      }
      
      private function updateBg() : void
      {
         this.background.x = App.appWidth - this.background.width >> 1;
         this.background.y = App.appHeight - this.background.height >> 1;
         x = -(this._scale - 1) * (INIT_COMPONENT_HALF_WIDTH + this.background.x) / this._scale >> 0;
         y = -(this._scale - 1) * (INIT_COMPONENT_HALF_HEIGHT + this.background.y) / this._scale >> 0;
      }
      
      private function relayout() : void
      {
         this.updateBg();
         var _loc1_:Number = this._appWidth - StageSizeBoundaries.WIDTH_1024 >> 1;
         var _loc2_:Number = this._appHeight - StageSizeBoundaries.HEIGHT_768 >> 1;
         this.versionTF.x = this._initVersionTFPos.x - _loc1_;
         this.versionTF.y = this._initVersionTFPos.y - _loc2_;
         this.form.y = this.wotLogo.y + FORM_VERTICAL_OFFSET ^ 0;
         this.copyright.y = this._initCopyrightPos.y + _loc2_;
         this.relayoutForLocale(_loc1_,_loc2_);
      }
      
      private function relayoutForLocale(param1:Number, param2:Number) : void
      {
         if(this._locale == Locales.KOREA)
         {
            this.relayoutKorea(param1,param2);
         }
         else if(this._locale == Locales.CHINA)
         {
            this.relayoutChina(param1,param2);
         }
      }
      
      private function relayoutKorea(param1:Number, param2:Number) : void
      {
         this.ageRating.x = this._initAgeRatingPos.x + param1;
         this.ageRating.y = this._initAgeRatingPos.y - param2;
         this._infoTF.x = INFO_TEXT_PADDING - (this._appWidth >> 1);
         this._infoTF.width = this._appWidth - 2 * INFO_TEXT_PADDING;
         var _loc3_:Number = this._appHeight - this.copyright.height - this.form.y - this._infoTF.y - param2;
         var _loc4_:TextFormat = this._infoTF.getTextFormat();
         if(this._infoTF.textHeight >= _loc3_)
         {
            while(this._infoTF.textHeight >= _loc3_)
            {
               _loc4_.size = int(_loc4_.size) - 1;
               this._infoTF.setTextFormat(_loc4_);
            }
         }
         else
         {
            while(this._infoTF.textHeight <= _loc3_ && _loc4_.size < MAX_INFO_FONT_SIZE)
            {
               _loc4_.size = int(_loc4_.size) + 1;
               this._infoTF.setTextFormat(_loc4_);
            }
         }
         this._infoTF.height = this._infoTF.textHeight + INFO_TEXT_HEIGHT_CORRECTION;
      }
      
      private function relayoutChina(param1:Number, param2:Number) : void
      {
         this.ageRating.x = StageSizeBoundaries.WIDTH_1024 - CHINA_AGE_RATING_OFFSET_X + param1;
         this.ageRating.y = CHINA_AGE_RATING_OFFSET_Y - param2;
      }
      
      private function onAwardsCompleteHandler(param1:UILoaderEvent) : void
      {
         this._awardsLoader.x = -(this._awardsLoader.width >> 1);
         this._awardsLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onAwardsCompleteHandler);
      }
   }
}
