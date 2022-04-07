package net.wg.gui.lobby.components
{
   import fl.motion.easing.Cubic;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.lobby.components.data.BaseMissionDetailedViewVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class BaseMissionDetailedView extends UIComponentEx
   {
      
      protected static const BIG_AWARDS_HEIGHT:int = 76;
      
      protected static const BIG_AWARDS_GAP:int = 35;
      
      protected static const BIG_AWARD_RENDERER_SIZE:int = 80;
      
      private static const SMALL_AWARDS_HEIGHT:int = 50;
      
      private static const SMALL_AWARDS_GAP:int = 22;
      
      private static const SMALL_AWARD_RENDERER_SIZE:int = 48;
      
      private static const BIG_AWARDS_MAX_NUM:int = 6;
      
      private static const DISABLED_ALPHA:Number = 0.7;
      
      private static const TWEEN_TIME:int = 300;
      
      private static const TWEEN_DELAY:int = 50;
      
      private static const TITLE_TF_WIDTH:int = 850;
      
      private static const DOTS:String = "...";
       
      
      public var titleTf:TextField;
      
      public var statusLabelTf:TextField;
      
      public var awardsBg:MovieClip;
      
      public var awardsGroup:IGroupEx;
      
      public var bottomStatusTf:TextField;
      
      public var bottomStatus2Tf:TextField;
      
      public var infoIcon:UILoaderAlt;
      
      private var _contentList:Vector.<DisplayObject>;
      
      private var _vo:BaseMissionDetailedViewVO;
      
      private var _contentAlpha:Number;
      
      private var _tweens:Vector.<IDisposable>;
      
      private var _isTitleTruncated:Boolean = false;
      
      private var _titleTooltip:String;
      
      private var _fadeInTween:Tween;
      
      private var _fadeOutTween:Tween;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _commons:ICommons;
      
      public function BaseMissionDetailedView()
      {
         this._tweens = new Vector.<IDisposable>(0);
         this._toolTipMgr = App.toolTipMgr;
         this._commons = App.utils.commons;
         super();
         this._contentList = new <DisplayObject>[this.titleTf,this.statusLabelTf,this.bottomStatusTf,this.bottomStatus2Tf,DisplayObject(this.awardsGroup),this.infoIcon];
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTf.addEventListener(MouseEvent.ROLL_OVER,this.onTitleTfRollOverHandler);
         this.titleTf.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.awardsGroup.layout = new CenterAlignedGroupLayout(BIG_AWARD_RENDERER_SIZE,BIG_AWARD_RENDERER_SIZE);
         this.awardsGroup.itemRendererLinkage = Linkages.AWARD_RENDERER;
         this.contentAlpha = Values.ZERO;
         this.statusLabelTf.addEventListener(MouseEvent.ROLL_OVER,this.onStatusLabelTfRollOverHandler);
         this.statusLabelTf.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.infoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
         this.infoIcon.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Tween = null;
         if(this._fadeInTween)
         {
            this._fadeInTween.paused = true;
            this._fadeInTween.dispose();
            this._fadeInTween = null;
         }
         if(this._fadeOutTween)
         {
            this._fadeOutTween.paused = true;
            this._fadeOutTween.dispose();
            this._fadeOutTween = null;
         }
         this.infoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
         this.infoIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.infoIcon.dispose();
         this.infoIcon = null;
         this.titleTf.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleTfRollOverHandler);
         this.titleTf.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.titleTf = null;
         this.statusLabelTf.removeEventListener(MouseEvent.ROLL_OVER,this.onStatusLabelTfRollOverHandler);
         this.statusLabelTf.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.statusLabelTf = null;
         this._vo = null;
         this._toolTipMgr = null;
         this._commons = null;
         this.awardsBg = null;
         this.awardsGroup.dispose();
         this.awardsGroup = null;
         this.bottomStatusTf = null;
         this.bottomStatus2Tf = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
         this._tweens = null;
         this._contentList.splice(0,this._contentList.length);
         this._contentList = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         super.draw();
         if(this._vo != null && isInvalid(InvalidationType.DATA))
         {
            this.titleTf.width = this.getTitleWidth();
            _loc1_ = this._vo.title;
            this.titleTf.htmlText = _loc1_;
            this._titleTooltip = this.titleTf.text;
            _loc2_ = this._commons.truncateTextFieldText(this.titleTf,_loc1_,true,true,DOTS);
            this._isTitleTruncated = _loc2_.length < _loc1_.length;
            if(this._isTitleTruncated)
            {
               this._commons.updateTextFieldSize(this.titleTf,true,false);
            }
            this.statusLabelTf.htmlText = this._vo.statusLabel;
            this.updateInfoIconParams();
            this.updateBottomStates();
            this.updateAwards();
            enabled = this._vo.isAvailable;
            this.playFadeInTween();
         }
      }
      
      public function getFocusItem() : InteractiveObject
      {
         return null;
      }
      
      public function setContentVisible(param1:Boolean) : void
      {
         this.contentAlpha = !!param1 ? Number(Values.DEFAULT_ALPHA) : Number(Values.ZERO);
      }
      
      public function setData(param1:BaseMissionDetailedViewVO) : void
      {
         this._vo = param1;
         this.playFadeOutTween();
      }
      
      public function updateVerticalCheckPoint(param1:Boolean) : void
      {
      }
      
      protected function getTitleWidth() : int
      {
         return TITLE_TF_WIDTH;
      }
      
      protected function addItemToContentList(param1:DisplayObject) : void
      {
         this._contentList.push(param1);
      }
      
      protected function showTooltip(param1:ToolTipVO) : void
      {
         if(param1)
         {
            if(param1.isSpecial)
            {
               this._toolTipMgr.showSpecial.apply(this,[param1.specialAlias,null].concat(param1.specialArgs));
            }
            else
            {
               this._toolTipMgr.showComplex(param1.tooltip);
            }
         }
      }
      
      protected function canItemBeDisabled(param1:DisplayObject) : Boolean
      {
         return false;
      }
      
      protected function getAwardsWidth() : int
      {
         throw new AbstractException("getAwardsWidth" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function showInfoTooltip() : void
      {
         this._toolTipMgr.showComplex(this._vo.titleTooltip);
      }
      
      protected function updateInfoIconParams() : void
      {
         throw new AbstractException("updateInfoIconParams" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function playFadeInTween() : void
      {
         this.stopTweens();
         if(this.contentAlpha < Values.DEFAULT_ALPHA)
         {
            this._fadeInTween = new Tween(TWEEN_TIME,this,{"contentAlpha":Values.DEFAULT_ALPHA},{
               "paused":false,
               "ease":Cubic.easeOut
            });
            this._tweens.push(this._fadeInTween);
         }
         this.awardsGroup.enabled = true;
      }
      
      protected function updateBottomStates() : void
      {
         throw new AbstractException("updateBottomStates" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function updateAwardsLayout() : void
      {
      }
      
      protected function playFadeOutTween() : void
      {
         this.awardsGroup.enabled = false;
         this.stopTweens();
         this._fadeOutTween = new Tween(TWEEN_TIME,this,{"contentAlpha":0},{
            "paused":false,
            "ease":Cubic.easeOut,
            "onComplete":invalidateData,
            "delay":TWEEN_DELAY
         });
         this._tweens.push(this._fadeOutTween);
      }
      
      private function updateAwards() : void
      {
         var _loc1_:Boolean = this._vo.awards.length <= BIG_AWARDS_MAX_NUM;
         var _loc2_:CenterAlignedGroupLayout = CenterAlignedGroupLayout(this.awardsGroup.layout);
         _loc2_.gap = !!_loc1_ ? int(BIG_AWARDS_GAP) : int(SMALL_AWARDS_GAP);
         _loc2_.rendererWidth = _loc2_.rendererHeight = !!_loc1_ ? int(BIG_AWARD_RENDERER_SIZE) : int(SMALL_AWARD_RENDERER_SIZE);
         this.awardsGroup.dataProvider = this._vo.awards;
         this.awardsGroup.width = this.getAwardsWidth();
         this.awardsGroup.height = !!_loc1_ ? Number(BIG_AWARDS_HEIGHT) : Number(SMALL_AWARDS_HEIGHT);
         this.updateAwardsLayout();
      }
      
      private function stopTweens() : void
      {
         if(this._fadeOutTween)
         {
            this._fadeOutTween.paused = true;
         }
         if(this._fadeInTween)
         {
            this._fadeInTween.paused = true;
         }
      }
      
      public function get contentAlpha() : Number
      {
         return this._contentAlpha;
      }
      
      public function set contentAlpha(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:DisplayObject = null;
         this._contentAlpha = param1;
         var _loc2_:Number = !!enabled ? Number(Values.DEFAULT_ALPHA) : Number(DISABLED_ALPHA);
         for each(_loc4_ in this._contentList)
         {
            _loc3_ = param1;
            if(param1 >= _loc2_ && this.canItemBeDisabled(_loc4_))
            {
               _loc3_ = _loc2_;
            }
            _loc4_.alpha = _loc3_;
         }
      }
      
      private function onInfoIconRollOverHandler(param1:MouseEvent) : void
      {
         this.showInfoTooltip();
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onStatusLabelTfRollOverHandler(param1:MouseEvent) : void
      {
         if(this._vo && StringUtils.isNotEmpty(this._vo.statusLabel))
         {
            this.showTooltip(this._vo.statusTooltipData);
         }
      }
      
      private function onTitleTfRollOverHandler(param1:MouseEvent) : void
      {
         if(this._isTitleTruncated)
         {
            this._toolTipMgr.show(this._titleTooltip);
         }
      }
   }
}
