package net.wg.gui.lobby.manualChapter
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.manualChapter.controls.DescriptionContainer;
   import net.wg.gui.lobby.manualChapter.controls.PageContentTemplate;
   import net.wg.gui.lobby.manualChapter.controls.TextContainer;
   import net.wg.gui.lobby.manualChapter.data.ManualPageDetailedViewVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class ManualPageView extends UIComponentEx
   {
       
      
      public var pageHeader:TextContainer;
      
      public var pageDescription:DescriptionContainer;
      
      public var vignetteBottom:MovieClip;
      
      public var vignetteTop:MovieClip;
      
      public var vignetteDescription:MovieClip;
      
      private var _contentRenderer:PageContentTemplate;
      
      private var _vo:ManualPageDetailedViewVO;
      
      private var _tweens:Vector.<IDisposable>;
      
      private var _contentScale:Number = 1;
      
      private var _renderLinkage:String = null;
      
      private var _fadingIn:Boolean = false;
      
      private const HINT_VERTICAL_PADDING:int = 35;
      
      private const BOTTOM_PADDING:int = 50;
      
      private const TOP_PADDING:int = 20;
      
      private const DIVIDER_WIDTH:int = 1026;
      
      private const SIZE_WIDTH:int = 1124;
      
      private const SIZE_HEIGHT:int = 780;
      
      private const IN_LABEl:String = "in";
      
      private const OUT_LABEl:String = "out";
      
      public function ManualPageView()
      {
         this._tweens = new Vector.<IDisposable>(0);
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         this.pageHeader.dispose();
         this.pageHeader = null;
         this.pageDescription.dispose();
         this.pageDescription = null;
         this.vignetteBottom = null;
         this.vignetteTop.addFrameScript(this.vignetteTop.totalFrames - 1,null);
         this.vignetteTop = null;
         this.vignetteDescription = null;
         this._vo = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
         this._tweens = null;
         this.disposeMessageView();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         super.draw();
         var _loc1_:int = this.SIZE_WIDTH * this._contentScale;
         _loc2_ = this.SIZE_HEIGHT * this._contentScale;
         _loc3_ = _loc1_ >> 1;
         var _loc4_:int = _loc2_ >> 1;
         var _loc5_:Boolean = isInvalid(InvalidationType.SIZE);
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         if(_loc5_)
         {
            if(this._contentRenderer)
            {
               this._contentRenderer.updateScaleFactor(this._contentScale);
            }
            this.pageDescription.updateScaleFactor(this._contentScale);
            this.pageHeader.updateScaleFactor(this._contentScale);
            this.vignetteBottom.scaleX = this.vignetteBottom.scaleY = this._contentScale;
            this.vignetteTop.scaleX = this.vignetteTop.scaleY = this._contentScale;
            this.vignetteDescription.scaleX = this.vignetteDescription.scaleY = this._contentScale;
            this.pageDescription.dividerMask.width = this.DIVIDER_WIDTH * this._contentScale;
            this.pageDescription.dividerMask.x = -this.pageDescription.dividerMask.width >> 1;
            this.pageHeader.x = _loc3_;
            this.pageHeader.y = this.TOP_PADDING;
            this.vignetteBottom.x = _loc3_;
            this.vignetteBottom.y = _loc4_;
            this.vignetteTop.x = _loc3_;
            this.vignetteTop.y = _loc4_;
            this.vignetteDescription.x = _loc3_;
            this.vignetteDescription.y = _loc4_;
         }
         if(this._vo != null && _loc6_)
         {
            this.createPageTemplate();
            if(this._contentRenderer)
            {
               this._contentRenderer.setData(this._vo.contentRendererData);
            }
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._fadingIn)
            {
               this.pageDescription.visible = StringUtils.isNotEmpty(this._vo.description);
               this.playFadeAnimations(this.IN_LABEl);
               if(this._contentRenderer)
               {
                  this._contentRenderer.fadeIn();
               }
               _loc5_ = true;
            }
            else
            {
               this.playFadeAnimations(this.OUT_LABEl);
               if(this._contentRenderer)
               {
                  this._contentRenderer.fadeOut();
               }
            }
         }
         if(_loc5_ || _loc6_)
         {
            this.pageDescription.text = this._vo.description;
            this.pageHeader.text = this._vo.title;
         }
         if(_loc5_)
         {
            this.pageDescription.x = _loc3_;
            this.pageDescription.y = _loc2_ - this.pageDescription.contentHeight - this.BOTTOM_PADDING * this._contentScale;
            if(this._contentRenderer)
            {
               this._contentRenderer.x = _loc3_;
               this._contentRenderer.validateNow();
               _loc7_ = this._contentRenderer.height;
               _loc8_ = this.pageDescription.visible;
               if(this._contentRenderer.isCentered())
               {
                  _loc9_ = !!_loc8_ ? int(this.pageDescription.contentHeight + this.BOTTOM_PADDING * this._contentScale) : int(0);
                  _loc10_ = this.pageHeader.y + this.pageHeader.contentHeight;
                  this._contentRenderer.y = _loc4_ - (_loc7_ - _loc10_ + _loc9_ >> 1);
               }
               else if(!_loc8_)
               {
                  this._contentRenderer.y = _loc2_ - _loc7_ - this.BOTTOM_PADDING * this._contentScale;
               }
               else
               {
                  this._contentRenderer.y = this.pageDescription.y - _loc7_ - this.HINT_VERTICAL_PADDING * this._contentScale;
               }
            }
         }
      }
      
      public function fadeIn() : void
      {
         this._fadingIn = true;
         invalidateState();
      }
      
      public function fadeOut() : void
      {
         this._fadingIn = false;
         invalidateState();
      }
      
      public function setData(param1:ManualPageDetailedViewVO) : void
      {
         this._vo = param1;
         invalidateData();
      }
      
      public function updateScaleFactor(param1:Number) : void
      {
         this._contentScale = param1;
         invalidateSize();
      }
      
      private function disposeMessageView() : void
      {
         if(this._contentRenderer)
         {
            removeChild(this._contentRenderer);
            this._contentRenderer.dispose();
            this._contentRenderer = null;
         }
      }
      
      private function createPageTemplate() : void
      {
         var _loc1_:String = this._vo.contentRendererLinkage;
         if(this._renderLinkage != _loc1_)
         {
            this.disposeMessageView();
            this._renderLinkage = _loc1_;
            if(StringUtils.isNotEmpty(this._renderLinkage))
            {
               this._contentRenderer = App.utils.classFactory.getComponent(this._renderLinkage,PageContentTemplate);
               addChild(this._contentRenderer);
               this._contentRenderer.updateScaleFactor(this._contentScale);
            }
         }
      }
      
      private function playFadeAnimations(param1:String) : void
      {
         this.pageHeader.gotoAndPlay(param1);
         var _loc2_:Boolean = this.pageDescription.visible;
         if(this._contentRenderer)
         {
            if(_loc2_ && this._contentRenderer.isSeparated())
            {
               this.pageDescription.divider.gotoAndPlay(param1);
            }
            this.vignetteBottom.gotoAndPlay(param1);
         }
         if(_loc2_)
         {
            this.pageDescription.gotoAndPlay(param1);
            this.vignetteDescription.gotoAndPlay(param1);
         }
         this.vignetteTop.gotoAndPlay(param1);
      }
      
      override public function get width() : Number
      {
         return this.SIZE_WIDTH * this._contentScale;
      }
      
      override public function get height() : Number
      {
         return this.SIZE_HEIGHT * this._contentScale;
      }
   }
}
