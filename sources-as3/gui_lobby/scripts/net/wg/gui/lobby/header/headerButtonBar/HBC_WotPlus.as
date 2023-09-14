package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.lobby.header.vo.HBC_WotPlusDataVO;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenHandler;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import net.wg.infrastructure.managers.ITweenManagerHelper;
   import net.wg.utils.ICommons;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.ITweenManager;
   import net.wg.utils.StageSizeBoundaries;
   
   public class HBC_WotPlus extends HeaderButtonContentItem implements IStageSizeDependComponent, ITweenHandler
   {
      
      private static const PADDING_RIGHT:int = 10;
       
      
      public var wotPlusIcon:IImage = null;
      
      public var label:TextField = null;
      
      public var state:TextField = null;
      
      public var noveltyIndicator:MovieClip = null;
      
      public var cross:MovieClip = null;
      
      private var fadeTween:ITween;
      
      private var _isCompact:Boolean = false;
      
      private var _commons:ICommons;
      
      public function HBC_WotPlus()
      {
         this._commons = App.utils.commons;
         super();
         minScreenPadding.left = 0;
         minScreenPadding.right = 0;
         additionalScreenPadding.left = 0;
         additionalScreenPadding.right = 0;
         App.stageSizeMgr.register(this);
      }
      
      override public function getSeparatorType() : String
      {
         return HeaderButtonContentItem.SEPARATOR_DOT;
      }
      
      override protected function onDispose() : void
      {
         this.disposeTween();
         App.stageSizeMgr.unregister(this);
         this.wotPlusIcon.dispose();
         this.wotPlusIcon = null;
         this.noveltyIndicator = null;
         this.cross = null;
         this.label = null;
         this.state = null;
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         this.label.visible = this.state.visible = !this._isCompact;
         if(this._isCompact)
         {
            bounds.width = this.label.x >> 0;
            minScreenPadding.right = 0;
         }
         else
         {
            bounds.width = Math.max(this.label.x + this.label.width,this.state.x + this.state.width) >> 0;
            minScreenPadding.right = PADDING_RIGHT;
         }
         super.updateSize();
      }
      
      override protected function updateData() : void
      {
         var _loc1_:HBC_WotPlusDataVO = null;
         if(data)
         {
            _loc1_ = HBC_WotPlusDataVO(data);
            this.wotPlusIcon.source = _loc1_.wotPlusIcon;
            this.label.htmlText = _loc1_.label;
            this.state.htmlText = _loc1_.state;
            if(_loc1_.showAsNew)
            {
               this.showNoveltyIndicator();
            }
            else
            {
               this.hideNoveltyIndicator();
            }
            this._commons.updateTextFieldSize(this.label,true,true);
            this._commons.updateTextFieldSize(this.state,true,true);
         }
         super.updateData();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = param1 < StageSizeBoundaries.WIDTH_1920;
         if(this._isCompact != _loc3_)
         {
            this._isCompact = _loc3_;
            invalidateSize();
         }
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
      }
      
      public function onComplete(param1:ITween) : void
      {
         this.disposeTween();
         this.noveltyIndicator.visible = false;
      }
      
      public function onStart(param1:ITween) : void
      {
      }
      
      private function showNoveltyIndicator() : void
      {
         this.disposeTween();
         this.cross.visible = true;
         this.noveltyIndicator.visible = true;
         this.noveltyIndicator.alpha = 1;
         this.noveltyIndicator.gotoAndPlay(0);
      }
      
      private function hideNoveltyIndicator() : void
      {
         this.cross.visible = false;
         this.noveltyIndicator.stop();
         var _loc1_:ITweenPropertiesVO = App.utils.tweenAnimator.createPropsForAlpha(this.noveltyIndicator,this.tweenMgrHelper.getFadeDurationSlow(),0,0);
         _loc1_.setPaused(false);
         this.fadeTween = this.tweenMgr.createNewTween(_loc1_);
         this.fadeTween.setHandler(this);
      }
      
      private function get tweenMgrHelper() : ITweenManagerHelper
      {
         return App.tweenMgr.getTweenManagerHelper();
      }
      
      private function get tweenMgr() : ITweenManager
      {
         return App.tweenMgr;
      }
      
      private function disposeTween() : void
      {
         if(this.fadeTween != null)
         {
            this.tweenMgr.disposeTweenS(this.fadeTween);
            this.fadeTween = null;
         }
      }
   }
}
