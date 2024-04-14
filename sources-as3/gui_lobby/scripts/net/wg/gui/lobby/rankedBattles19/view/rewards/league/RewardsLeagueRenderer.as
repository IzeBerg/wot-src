package net.wg.gui.lobby.rankedBattles19.view.rewards.league
{
   import fl.motion.easing.Cubic;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.lobby.rankedBattles19.data.RewardsLeagueRendererVO;
   import net.wg.gui.lobby.rankedBattles19.events.RewardsEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.MouseEventEx;
   
   public class RewardsLeagueRenderer extends UIComponentEx
   {
      
      private static const ICON_TEXT_GAP_WIDE:int = 25;
      
      private static const ICON_TEXT_GAP_NORMAL:int = 15;
      
      private static const CONTENT_PADDING_WIDE:int = 40;
      
      private static const CONTENT_PADDING_NORMAL:int = 20;
      
      public static const STYLE_ICON_WIDTH_NORMAL:int = 200;
      
      public static const STYLE_ICON_WIDTH_WIDE:int = 300;
      
      public static const RENDERER_WIDTH_NORMAL:int = 280;
      
      public static const RENDERER_WIDTH_NARROW:int = 320;
      
      public static const RENDERER_WIDTH_WIDE:int = 400;
      
      private static const RENDERER_INVISIBLE_WIDTH_PART:int = 2;
      
      private static const ANIMATION_STYLE_REWARD_GAP:int = 50;
      
      private static const ANIMATION_STYLE_REWARD_TIME:int = 300;
      
      private static const ANIMATION_STYLE_REWARD_DELAY:int = 150;
      
      private static const LEAGUE_FRAME:String = "league";
       
      
      public var hitMc:MovieClip;
      
      public var leagueNameTf:TextField = null;
      
      public var rewardDescriptionTf:TextField = null;
      
      public var currentRewardTf:TextField = null;
      
      public var styleReward:RewardsLeagueStyleReward = null;
      
      public var bg:FrameStateCmpnt = null;
      
      private var _data:RewardsLeagueRendererVO = null;
      
      private var _rendererWidth:int = 0;
      
      private var _styleIconWidth:int = 0;
      
      private var _setStyleWidth:int = 0;
      
      private var _topContentPadding:int = 0;
      
      private var _iconTextPadding:int = 25;
      
      private var _startTween:Tween = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function RewardsLeagueRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         this.bg.allowResize = true;
         this.styleReward.alpha = 0;
         this.currentRewardTf.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hitMc.buttonMode = true;
         this.hitMc.useHandCursor = true;
         this.currentRewardTf.text = RANKED_BATTLES.REWARDSVIEW_COMMON_CURRENTREWARD;
         this.addEventListener(MouseEvent.CLICK,this.onStyleRewardClickHandler);
         this.addEventListener(MouseEvent.ROLL_OVER,this.onBlockRollOverHandler);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onBlockRollOutHandler);
         this.bg.x = RENDERER_INVISIBLE_WIDTH_PART >> 1;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.updateData();
               invalidateSize();
               this.styleReward.y = this._topContentPadding - ANIMATION_STYLE_REWARD_GAP;
               this._startTween = new Tween(ANIMATION_STYLE_REWARD_TIME,this.styleReward,{
                  "alpha":1,
                  "y":this._topContentPadding
               },{
                  "paused":false,
                  "ease":Cubic.easeIn,
                  "onComplete":this.onRewardShowed,
                  "delay":(this._data.leagueID - 1) * ANIMATION_STYLE_REWARD_DELAY
               });
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.leagueNameTf.width = this.rewardDescriptionTf.width = this.currentRewardTf.width = this._rendererWidth;
               App.utils.commons.updateTextFieldSize(this.rewardDescriptionTf,false,true);
               this.styleReward.x = this._rendererWidth - this._styleIconWidth >> 1;
               if(this._startTween.paused)
               {
                  this.styleReward.y = this._topContentPadding;
               }
               this.leagueNameTf.y = this._topContentPadding + this._styleIconWidth + this._iconTextPadding;
               this.rewardDescriptionTf.y = this.leagueNameTf.y + this.leagueNameTf.height | 0;
               this.currentRewardTf.y = this.rewardDescriptionTf.y + this.rewardDescriptionTf.height | 0;
               _width = this._rendererWidth;
               _height = this.currentRewardTf.y + this._topContentPadding;
               this.bg.width = this._rendererWidth - RENDERER_INVISIBLE_WIDTH_PART;
               this.bg.height = _height;
               this.hitMc.x = this.bg.x;
               this.hitMc.width = this.bg.width;
               this.hitMc.height = this.bg.height;
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.onStyleRewardClickHandler);
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onBlockRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onBlockRollOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._toolTipMgr = null;
         this.currentRewardTf = null;
         this.leagueNameTf = null;
         this.rewardDescriptionTf = null;
         this.styleReward.dispose();
         this.styleReward = null;
         this.hitMc = null;
         this._data.dispose();
         this._data = null;
         this.bg.dispose();
         this.bg = null;
         this._startTween.paused = true;
         this._startTween.dispose();
         this._startTween = null;
         super.onDispose();
      }
      
      public function setData(param1:RewardsLeagueRendererVO) : void
      {
         if(this._data == param1)
         {
            return;
         }
         this._data = param1;
         invalidateData();
      }
      
      public function setRendererWidth(param1:int, param2:int) : void
      {
         if(this._rendererWidth == param1 && this._styleIconWidth == param2)
         {
            return;
         }
         this._setStyleWidth = this._styleIconWidth;
         this._rendererWidth = param1;
         this._styleIconWidth = param2;
         if(this._rendererWidth == RENDERER_WIDTH_NORMAL)
         {
            this._topContentPadding = CONTENT_PADDING_NORMAL;
            this._iconTextPadding = ICON_TEXT_GAP_NORMAL;
         }
         else
         {
            this._topContentPadding = CONTENT_PADDING_WIDE;
            this._iconTextPadding = ICON_TEXT_GAP_WIDE;
         }
         this.updateStyleReward();
         invalidateSize();
      }
      
      private function updateData() : void
      {
         this.leagueNameTf.htmlText = this._data.title;
         this.rewardDescriptionTf.htmlText = this._data.description;
         this.updateStyleReward();
         this.bg.frameLabel = LEAGUE_FRAME + this._data.leagueID.toString();
      }
      
      private function updateStyleReward() : void
      {
         if(this._setStyleWidth != this._styleIconWidth)
         {
            if(this._styleIconWidth == STYLE_ICON_WIDTH_NORMAL)
            {
               this.styleReward.setData(RewardsLeagueStyleReward.SIZE_NORMAL,this._data.styleID);
            }
            else
            {
               this.styleReward.setData(RewardsLeagueStyleReward.SIZE_WIDE,this._data.styleID);
            }
         }
      }
      
      private function onRewardShowed() : void
      {
         this.styleReward.selected = this._data.isCurrent;
         this.currentRewardTf.visible = this._data.isCurrent;
         dispatchEvent(new RewardsEvent(RewardsEvent.RENDERER_ANIMATION_COMPLETE,this._data.leagueID,true));
      }
      
      private function onStyleRewardClickHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(MouseEventEx.LEFT_BUTTON) : uint(_loc2_.buttonIdx);
         if(_loc3_ != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         dispatchEvent(new RewardsEvent(RewardsEvent.SHOW_STYLE,this._data.styleID,true));
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.RANKED_BATTLES_CAMOUFLAGE_REWARD,null);
      }
      
      private function onBlockRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
         this.styleReward.out();
      }
      
      private function onBlockRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(TOOLTIPS.AWARDITEM_ONEOF_RANKEDSEASON_PREVIEWSTYLE);
         this.styleReward.over();
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.RANKED_BATTLES_CAMOUFLAGE_REWARD,null);
      }
   }
}
