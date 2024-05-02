package net.wg.gui.lobby.battlequeue
{
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.ui.Keyboard;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.common.containers.GroupExAnimated;
   import net.wg.gui.components.common.waiting.WaitingComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.icons.BattleTypeIcon;
   import net.wg.gui.events.AnimatedRendererEvent;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.base.meta.IBattleStrongholdsQueueMeta;
   import net.wg.infrastructure.base.meta.impl.BattleStrongholdsQueueMeta;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   
   public class BattleStrongholdsQueue extends BattleStrongholdsQueueMeta implements IBattleStrongholdsQueueMeta
   {
      
      private static const MIN_POS_Y:int = 40;
      
      private static const INV_TYPE_INFO:String = "InvTypeInfo";
      
      private static const LEAGUE_ICON_OFFSET:int = 17;
      
      private static const LEAGUES_RENDERER_WIDTH:Number = 250;
      
      private static const LEAGUES_RENDERER_HEIGHT:Number = 250;
      
      private static const LEAGUES_POS_X:Number = 405;
      
      private static const LEAGUES_POS_Y:Number = 255;
      
      private static const LEAGUES_GAP:uint = 0;
      
      private static const LEAGUE_RENDERER:String = "BattleStrongholdsLeaguesRendererUI";
       
      
      public var timerLabel:TextField;
      
      public var timerText:TextField;
      
      public var myClanLabel:TextField;
      
      public var myClanName:TextField;
      
      public var myClanElo:TextField;
      
      public var myClanRating:TextField;
      
      public var myClanRatingLabel:TextField;
      
      public var myClanIcon:UILoaderAlt;
      
      public var leagueIcon:UILoaderAlt;
      
      public var leaguesLabel:TextField;
      
      public var modeTitle:TextField;
      
      public var exitButton:ISoundButtonEx;
      
      public var battleIcon:BattleTypeIcon;
      
      public var waiting:WaitingComponent = null;
      
      private var _typeInfo:BattleStrongholdsQueueTypeInfoVO;
      
      private var _leaguesModel:BattleStrongholdsLeaguesVO;
      
      private var _isFirstDataset:Boolean = true;
      
      private var _leaguesGroup:GroupExAnimated = null;
      
      public function BattleStrongholdsQueue()
      {
         super();
         this._leaguesGroup = new GroupExAnimated();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.x = param1 - this.actualWidth >> 1;
         this.y = Math.max(param2 - this.actualHeight >> 1,MIN_POS_Y);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.exitButton.addEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
         this.leagueIcon.addEventListener(UILoaderEvent.COMPLETE,this.OnIconLoadCompleteHandler);
         this.myClanIcon.addEventListener(UILoaderEvent.COMPLETE,this.OnIconLoadCompleteHandler);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
         this._leaguesGroup.layout = new CenterAlignedGroupLayout(LEAGUES_RENDERER_WIDTH,LEAGUES_RENDERER_HEIGHT);
         this._leaguesGroup.addEventListener(AnimatedRendererEvent.ANIMATION_FINISHED,this.onAnimationFinishedHandler);
         this._leaguesGroup.itemRendererLinkage = LEAGUE_RENDERER;
         CenterAlignedGroupLayout(this._leaguesGroup.layout).gap = LEAGUES_GAP;
         this._leaguesGroup.mouseChildren = false;
         addChild(this._leaguesGroup);
         this._leaguesGroup.x = LEAGUES_POS_X;
         this._leaguesGroup.y = LEAGUES_POS_Y;
         this.myClanLabel.autoSize = TextFieldAutoSize.LEFT;
         this.myClanLabel.text = FORTIFICATIONS.BATTLEQUEUE_YOURTEAM;
         this.myClanRatingLabel.autoSize = TextFieldAutoSize.RIGHT;
         this.myClanRatingLabel.text = FORTIFICATIONS.BATTLEQUEUE_POSITION;
         this.myClanRatingLabel.visible = false;
         this.myClanName.autoSize = TextFieldAutoSize.LEFT;
         this.waiting.backgroundVisibility = false;
         this.battleIcon.visible = false;
      }
      
      override protected function setTypeInfo(param1:BattleStrongholdsQueueTypeInfoVO) : void
      {
         this._typeInfo = param1;
         invalidate(INV_TYPE_INFO);
      }
      
      override protected function draw() : void
      {
         if(this._typeInfo && isInvalid(INV_TYPE_INFO))
         {
            this.modeTitle.text = this._typeInfo.title;
            this.battleIcon.type = this._typeInfo.iconLabel;
            this.battleIcon.visible = true;
            this.myClanName.htmlText = this._typeInfo.myClanName;
            if(StringUtils.isEmpty(this._typeInfo.myClanRating))
            {
               this.myClanRating.visible = this.myClanRatingLabel.visible = false;
            }
            else
            {
               this.myClanRating.visible = this.myClanRatingLabel.visible = true;
               this.myClanRating.htmlText = this._typeInfo.myClanRating;
            }
            this.myClanElo.htmlText = this._typeInfo.myClanElo;
            this.leagueIcon.source = this._typeInfo.leagueIcon;
            this.myClanIcon.source = this._typeInfo.myClanIcon;
         }
         if(this._leaguesModel && isInvalid(InvalidationType.DATA))
         {
            this.leaguesLabel.htmlText = this._leaguesModel.title;
            this._leaguesGroup.dataProvider = this._leaguesModel.leagues;
         }
         if(this._typeInfo && isInvalid(InvalidationType.SIZE))
         {
            this.leagueIcon.x = Math.round(this.myClanLabel.x + this.myClanLabel.width + LEAGUE_ICON_OFFSET);
            this.myClanIcon.x = this.leagueIcon.x + 0.5 * (this.leagueIcon.originalWidth - this.myClanIcon.originalWidth);
         }
         super.draw();
      }
      
      override protected function setLeagues(param1:BattleStrongholdsLeaguesVO) : void
      {
         this._leaguesModel = param1;
         if(this._isFirstDataset)
         {
            this._isFirstDataset = false;
            invalidateData();
         }
         else
         {
            this._leaguesGroup.playEndAnimation();
         }
      }
      
      public function as_setTimer(param1:String, param2:String) : void
      {
         this.timerLabel.htmlText = param1;
         this.timerText.htmlText = param2;
      }
      
      public function as_showExit(param1:Boolean) : void
      {
         this.exitButton.visible = param1;
      }
      
      public function as_showWaiting(param1:String) : void
      {
         this.waiting.visible = true;
         this.waiting.backgroundVisibility = false;
         this.waiting.setMessage(param1);
      }
      
      public function as_hideWaiting() : void
      {
         this.waiting.visible = false;
      }
      
      override protected function onDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
         this.exitButton.removeEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
         this.myClanLabel = null;
         this.myClanElo = null;
         this.myClanRating = null;
         this.myClanRatingLabel = null;
         this.timerLabel = null;
         this.leaguesLabel = null;
         this.modeTitle = null;
         this.timerText = null;
         this.exitButton.dispose();
         this.exitButton = null;
         this.battleIcon.dispose();
         this.battleIcon = null;
         this._typeInfo.dispose();
         this._typeInfo = null;
         this.myClanIcon.removeEventListener(UILoaderEvent.COMPLETE,this.OnIconLoadCompleteHandler);
         this.myClanIcon.dispose();
         this.myClanIcon = null;
         this.leagueIcon.removeEventListener(UILoaderEvent.COMPLETE,this.OnIconLoadCompleteHandler);
         this.leagueIcon.dispose();
         this.leagueIcon = null;
         this.myClanName = null;
         this._leaguesGroup.removeEventListener(AnimatedRendererEvent.ANIMATION_FINISHED,this.onAnimationFinishedHandler);
         this._leaguesGroup.dispose();
         this._leaguesGroup = null;
         this.waiting.dispose();
         this.waiting = null;
         super.onDispose();
      }
      
      private function handleEscape(param1:InputEvent) : void
      {
         onEscapeS();
      }
      
      private function onExitButtonClickHandler(param1:ButtonEvent) : void
      {
         exitClickS();
      }
      
      private function OnIconLoadCompleteHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onAnimationFinishedHandler(param1:AnimatedRendererEvent) : void
      {
         invalidateData();
      }
   }
}
