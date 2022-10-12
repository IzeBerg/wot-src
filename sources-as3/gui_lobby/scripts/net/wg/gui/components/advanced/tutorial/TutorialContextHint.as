package net.wg.gui.components.advanced.tutorial
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.vo.TutorialContextHintVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class TutorialContextHint extends UIComponentEx
   {
      
      private static const HINT_ICON_X_OFFSET:int = -10;
      
      private static const TEXT_PADDING:int = 20;
      
      private static const TEXT_ANTIALIASING_PADDING:int = 5;
       
      
      public var background:Sprite = null;
      
      public var hintIcon:UILoaderAlt = null;
      
      public var hintTF:TextField = null;
      
      private var _tooltipSpecial:String = "";
      
      private var _tooltipComplex:String = "";
      
      private var _tooltipArgs:Object = null;
      
      private var _model:TutorialContextHintVO = null;
      
      private var _iconLoaded:Boolean = false;
      
      private var _iconLoadError:Boolean = false;
      
      public function TutorialContextHint()
      {
         super();
      }
      
      private static function onBackGroundRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hintIcon.autoSize = false;
         this.hintTF.visible = false;
         this.hintIcon.visible = false;
         this.hintIcon.mouseEnabled = false;
         this.hintIcon.mouseChildren = false;
         this.hintTF.mouseEnabled = false;
         this.hintIcon.addEventListener(UILoaderEvent.COMPLETE,this.onHintIconLoadCompleteHandler);
         this.hintIcon.addEventListener(UILoaderEvent.IOERROR,this.onHintIconIOErrorHandler);
         this.background.addEventListener(MouseEvent.ROLL_OVER,this.onBackgroundRollOverHandler);
         this.background.addEventListener(MouseEvent.ROLL_OUT,onBackGroundRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         this.hintIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onHintIconLoadCompleteHandler);
         this.hintIcon.removeEventListener(UILoaderEvent.IOERROR,this.onHintIconIOErrorHandler);
         this.background.removeEventListener(MouseEvent.ROLL_OVER,this.onBackgroundRollOverHandler);
         this.background.removeEventListener(MouseEvent.ROLL_OUT,onBackGroundRollOutHandler);
         this.background = null;
         this.hintIcon.dispose();
         this.hintIcon = null;
         this.hintTF = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(this._model != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this._tooltipSpecial = this._model.tooltipSpecial;
               this._tooltipComplex = this._model.tooltipComplex;
               this._tooltipArgs = this._model.args;
               if(this._model.iconSource != Values.EMPTY_STR)
               {
                  this.hintIcon.source = this._model.iconSource;
               }
               if(this._model.hintText != Values.EMPTY_STR)
               {
                  this.hintTF.htmlText = this._model.hintText;
               }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.background.width = _width;
               this.background.height = _height;
               if(this._model.iconSource != Values.EMPTY_STR && !this._iconLoaded && !this._iconLoadError)
               {
                  return;
               }
               if(this._model.hintText != Values.EMPTY_STR)
               {
                  _loc1_ = this.background.width - TEXT_PADDING * 2;
                  _loc1_ -= !!this._iconLoaded ? HINT_ICON_X_OFFSET + this.hintIcon.width : 0;
                  this.hintTF.width = _loc1_;
                  if(this.hintTF.textWidth + TEXT_ANTIALIASING_PADDING < _loc1_)
                  {
                     this.hintTF.width = this.hintTF.textWidth + TEXT_ANTIALIASING_PADDING;
                  }
                  this.hintTF.height = this.hintTF.textHeight + TEXT_ANTIALIASING_PADDING;
                  _loc2_ = !!this._iconLoaded ? int(this.hintTF.width + HINT_ICON_X_OFFSET + this.hintIcon.width) : int(this.hintTF.width);
                  this.hintTF.x = this.background.width - _loc2_ >> 1;
                  if(this._iconLoaded)
                  {
                     this.hintIcon.x = this.hintTF.x + this.hintTF.width + HINT_ICON_X_OFFSET ^ 0;
                     this.hintIcon.y = this.background.height - this.hintIcon.height >> 1;
                     this.hintTF.y = this.hintIcon.y + (this.hintIcon.height - this.hintTF.height >> 1);
                  }
                  else
                  {
                     this.hintTF.y = this.background.height - this.hintTF.textHeight >> 1;
                  }
                  this.hintTF.visible = true;
               }
               else if(this._iconLoaded)
               {
                  this.hintIcon.x = this.background.width - this.hintIcon.width >> 1;
                  this.hintIcon.y = this.background.height - this.hintIcon.height >> 1;
               }
            }
         }
      }
      
      public function setData(param1:TutorialContextHintVO) : void
      {
         if(param1 != null)
         {
            this._model = param1;
            invalidateData();
         }
      }
      
      private function onBackgroundRollOverHandler(param1:MouseEvent) : void
      {
         if(this._tooltipSpecial != Values.EMPTY_STR)
         {
            App.toolTipMgr.showSpecial(this._tooltipSpecial,null,this._tooltipArgs);
         }
         else if(this._tooltipComplex != Values.EMPTY_STR)
         {
            App.toolTipMgr.showComplex(this._tooltipComplex);
         }
      }
      
      private function onHintIconLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         this.hintIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onHintIconLoadCompleteHandler);
         this._iconLoaded = true;
         invalidateSize();
         this.hintIcon.visible = true;
      }
      
      private function onHintIconIOErrorHandler(param1:UILoaderEvent) : void
      {
         this.hintIcon.removeEventListener(UILoaderEvent.IOERROR,this.onHintIconIOErrorHandler);
         this._iconLoadError = true;
         invalidateSize();
      }
   }
}
