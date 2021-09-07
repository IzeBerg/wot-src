package net.wg.gui.lobby.rankedBattles19.view.rewards
{
   import fl.transitions.easing.Strong;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.rankedBattles19.data.RewardsLeagueVO;
   import net.wg.gui.lobby.rankedBattles19.events.RewardsEvent;
   import net.wg.gui.lobby.rankedBattles19.view.rewards.league.RewardsLeagueContainer;
   import net.wg.gui.lobby.rankedBattles19.view.rewards.league.RewardsLeagueRenderer;
   import net.wg.infrastructure.base.meta.IRankedBattlesRewardsLeaguesMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesRewardsLeaguesMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class RankedBattlesRewardsLeaguesView extends RankedBattlesRewardsLeaguesMeta implements IRankedBattlesRewardsLeaguesMeta, IStageSizeDependComponent
   {
      
      private static const CONTAINER_TOP_PADDING_SMALL:int = 15;
      
      private static const CONTAINER_TOP_PARENT_OFFSET:int = 18;
      
      private static const INFO_BLOCK_MAX_HEIGHT:uint = 130;
      
      private static const INFO_BLOCK_PADDING:int = 30;
      
      private static const INFO_BLOCK_ANIMATION_SPEED:uint = 300;
      
      private static const INFO_BLOCK_ANIMATION_DELAY:uint = 100;
      
      private static const FONT_SIZE_TF_DESC_SMALL:uint = 14;
      
      private static const FONT_SIZE_TF_DESC_BIG:uint = 16;
       
      
      public var container:RewardsLeagueContainer = null;
      
      public var rewardsDescriptionTf:TextField = null;
      
      public var rewardsDivider:Sprite = null;
      
      private var _rewards:RewardsLeagueVO = null;
      
      private var _containerGlobalLeftShift:Number = 0;
      
      private var _renderersAnimationFinished:int = 0;
      
      private var _infoTextFadeOut:Tween = null;
      
      private var _hasDescr:Boolean = false;
      
      public function RankedBattlesRewardsLeaguesView()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         this.container.addEventListener(Event.RESIZE,this.onContainerResizeHandler);
         App.stageSizeMgr.register(this);
         super.onPopulate();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.rewardsDescriptionTf.alpha = 0;
         this.container.addEventListener(RewardsEvent.SHOW_STYLE,this.onShowStyleHandler,true);
         this.container.addEventListener(RewardsEvent.RENDERER_ANIMATION_COMPLETE,this.onRendererAnimationCompleteHandler,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_VIEW_PADDING))
         {
            this._containerGlobalLeftShift = Boolean(viewPadding) ? Number(viewPadding.left >> 1) : Number(Values.ZERO);
            invalidateSize();
         }
         if(this._rewards)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.updateRewardsData();
               this._hasDescr = StringUtils.isNotEmpty(this._rewards.description);
               this.rewardsDivider.visible = this._hasDescr;
               this.rewardsDescriptionTf.visible = this._hasDescr;
               if(this._hasDescr)
               {
                  this.rewardsDescriptionTf.text = this._rewards.description;
               }
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.updateComponentsPosition();
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.container.removeEventListener(Event.RESIZE,this.onContainerResizeHandler,true);
         this.container.removeEventListener(RewardsEvent.SHOW_STYLE,this.onShowStyleHandler,true);
         this.container.removeEventListener(RewardsEvent.RENDERER_ANIMATION_COMPLETE,this.onRendererAnimationCompleteHandler,true);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.container.dispose();
         this.container = null;
         this.rewardsDivider = null;
         this.rewardsDescriptionTf = null;
         this._rewards = null;
         if(this._infoTextFadeOut)
         {
            this._infoTextFadeOut.paused = true;
            this._infoTextFadeOut.dispose();
            this._infoTextFadeOut = null;
         }
         super.onDispose();
      }
      
      override protected function setRewards(param1:RewardsLeagueVO) : void
      {
         this._rewards = param1;
         this._renderersAnimationFinished = 0;
         invalidateData();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this.updateDescriptionFontSize(param2);
         if(param2 <= StageSizeBoundaries.HEIGHT_768)
         {
            this.container.setRendererWidth(RewardsLeagueRenderer.RENDERER_WIDTH_NORMAL,RewardsLeagueRenderer.STYLE_ICON_WIDTH_NORMAL);
         }
         else if(param1 >= StageSizeBoundaries.WIDTH_1920 && param2 >= StageSizeBoundaries.HEIGHT_1080)
         {
            this.container.setRendererWidth(RewardsLeagueRenderer.RENDERER_WIDTH_WIDE,RewardsLeagueRenderer.STYLE_ICON_WIDTH_WIDE);
         }
         else if(param1 >= StageSizeBoundaries.WIDTH_1366)
         {
            this.container.setRendererWidth(RewardsLeagueRenderer.RENDERER_WIDTH_NARROW,RewardsLeagueRenderer.STYLE_ICON_WIDTH_NORMAL);
         }
         else
         {
            this.container.setRendererWidth(RewardsLeagueRenderer.RENDERER_WIDTH_NORMAL,RewardsLeagueRenderer.STYLE_ICON_WIDTH_NORMAL);
         }
      }
      
      private function updateDescriptionFontSize(param1:int) : void
      {
         var _loc2_:int = FONT_SIZE_TF_DESC_BIG;
         if(param1 <= StageSizeBoundaries.HEIGHT_900)
         {
            _loc2_ = FONT_SIZE_TF_DESC_SMALL;
         }
         var _loc3_:TextFormat = this.rewardsDescriptionTf.getTextFormat();
         _loc3_.size = _loc2_;
         if(this._hasDescr)
         {
            this.rewardsDescriptionTf.setTextFormat(_loc3_);
         }
         else
         {
            this.rewardsDescriptionTf.defaultTextFormat = _loc3_;
         }
      }
      
      private function updateComponentsPosition() : void
      {
         var _loc1_:Boolean = false;
         App.utils.commons.updateTextFieldSize(this.rewardsDescriptionTf,false,true);
         _loc1_ = _width > this.container.width;
         var _loc2_:int = _width >> 1;
         var _loc3_:int = !!_loc1_ ? int(_loc2_ - this._containerGlobalLeftShift) : int(_loc2_);
         var _loc4_:int = INFO_BLOCK_MAX_HEIGHT;
         if(this._hasDescr)
         {
            _loc4_ = Math.min(this.rewardsDescriptionTf.height + 2 * INFO_BLOCK_PADDING,INFO_BLOCK_MAX_HEIGHT);
            this.rewardsDivider.x = _loc3_ - (this.rewardsDivider.width >> 1);
            this.rewardsDivider.y = _height - _loc4_ - this.rewardsDivider.height | 0;
            this.rewardsDescriptionTf.x = _loc3_ - (this.rewardsDescriptionTf.width >> 1);
            this.rewardsDescriptionTf.y = _height - (_loc4_ + this.rewardsDescriptionTf.height >> 1) | 0;
         }
         var _loc5_:int = Math.max(_height - this.container.height - _loc4_ >> 1,CONTAINER_TOP_PADDING_SMALL);
         this.container.x = _loc3_;
         this.container.y = _loc5_ - CONTAINER_TOP_PARENT_OFFSET;
      }
      
      private function updateRewardsData() : void
      {
         this.container.data = this._rewards.leagues;
      }
      
      private function onContainerResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onShowStyleHandler(param1:RewardsEvent) : void
      {
         onStyleClickS(param1.data);
      }
      
      private function onRendererAnimationCompleteHandler(param1:RewardsEvent) : void
      {
         if(!this._hasDescr)
         {
            return;
         }
         ++this._renderersAnimationFinished;
         if(this._renderersAnimationFinished == this._rewards.leaguesCount)
         {
            this._infoTextFadeOut = new Tween(INFO_BLOCK_ANIMATION_SPEED,this.rewardsDescriptionTf,{"alpha":1},{
               "paused":false,
               "ease":Strong.easeIn,
               "delay":INFO_BLOCK_ANIMATION_DELAY
            });
         }
      }
   }
}
