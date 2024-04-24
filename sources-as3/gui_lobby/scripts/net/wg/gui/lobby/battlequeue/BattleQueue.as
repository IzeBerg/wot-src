package net.wg.gui.lobby.battlequeue
{
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.constants.AlignType;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.ImageComponent;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.meta.IBattleQueueMeta;
   import net.wg.infrastructure.base.meta.impl.BattleQueueMeta;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   
   public class BattleQueue extends BattleQueueMeta implements IBattleQueueMeta
   {
      
      private static const MAX_POS_Y:int = 80;
      
      private static const INV_TYPE_INFO:String = "InvTypeInfo";
      
      private static const TNK_ICON_OFFSET:int = 16;
      
      private static const LAYOUT_TYPE_EMPTY:String = "empty";
      
      private static const LAYOUT_TYPE_COMP7:String = "comp7";
      
      private static const LAYOUT_TYPE_BATTLE_ROYAL:String = "battleRoyale";
      
      private static const LIST_HEIGHT_COMP7:int = 350;
      
      private static const LIST_HEIGHT_BATTLE_ROYAL:int = 100;
      
      private static const LIST_HEIGHT_USUAL:int = 250;
      
      private static const FUN_RANDOM_BATTLE_ICON_BG:String = "fun_random";
       
      
      public var timerLabel:TextField;
      
      public var timerText:TextField;
      
      public var tankLabel:TextField;
      
      public var tankName:TextField;
      
      public var tankIcon:ImageComponent;
      
      public var playersLabel:TextField;
      
      public var gameplayTip:TextField;
      
      public var additional:TextField;
      
      public var modeTitle:TextField;
      
      public var subTitle:TextField;
      
      public var footerText:TextField;
      
      public var exitButton:ISoundButtonEx;
      
      public var listByType:ScrollingListEx;
      
      public var startButton:ISoundButtonEx;
      
      public var battleIcon:Image;
      
      public var battleTypeIcon:Image;
      
      public var battleIconBg:FrameStateCmpnt;
      
      private var _typeInfo:BattleQueueTypeInfoVO;
      
      private var _battleIconBgFrameHelper:FrameHelper;
      
      private var _viewFrameHelper:FrameHelper;
      
      public function BattleQueue()
      {
         super();
      }
      
      private static function getListHeight(param1:String) : int
      {
         if(param1 == LAYOUT_TYPE_COMP7)
         {
            return LIST_HEIGHT_COMP7;
         }
         if(param1 == LAYOUT_TYPE_BATTLE_ROYAL)
         {
            return LIST_HEIGHT_BATTLE_ROYAL;
         }
         return LIST_HEIGHT_USUAL;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         x = param1 - actualWidth >> 1;
         y = Math.max(Math.min(-parent.y + (param2 - actualHeight >> 1) ^ 0,MAX_POS_Y),-MAX_POS_Y);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._viewFrameHelper = new FrameHelper(this);
         this._battleIconBgFrameHelper = new FrameHelper(this.battleIconBg);
         this.startButton.visible = false;
         this.listByType.mouseChildren = false;
         this.tankIcon.tooltipEnabled = false;
         this.tankIcon.horizontalAlign = AlignType.CENTER;
         this.tankIcon.verticalAlign = AlignType.CENTER;
         this.startButton.addEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
         this.exitButton.addEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
      }
      
      override protected function onDispose() : void
      {
         if(this._viewFrameHelper)
         {
            this._viewFrameHelper.dispose();
            this._viewFrameHelper = null;
         }
         if(this._battleIconBgFrameHelper)
         {
            this._battleIconBgFrameHelper.dispose();
            this._battleIconBgFrameHelper = null;
         }
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
         this.listByType.disposeRenderers();
         this.startButton.removeEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
         this.exitButton.removeEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
         this.tankLabel = null;
         this.timerLabel = null;
         this.playersLabel = null;
         this.gameplayTip = null;
         this.modeTitle = null;
         this.subTitle = null;
         this.footerText = null;
         this.timerText = null;
         this.tankName = null;
         this.exitButton.dispose();
         this.exitButton = null;
         this.listByType.dispose();
         this.listByType = null;
         this.startButton.dispose();
         this.startButton = null;
         this.battleIcon.dispose();
         this.battleIcon = null;
         this.additional = null;
         this._typeInfo.dispose();
         this._typeInfo = null;
         this.tankIcon.dispose();
         this.tankIcon = null;
         if(this.battleTypeIcon)
         {
            this.battleTypeIcon.dispose();
            this.battleTypeIcon = null;
         }
         this.battleIconBg.dispose();
         this.battleIconBg = null;
         super.onDispose();
      }
      
      override protected function setDP(param1:DataProvider) : void
      {
         this.listByType.dataProvider = param1;
         if(!this.listByType.visible)
         {
            this.listByType.visible = true;
         }
      }
      
      override protected function setTypeInfo(param1:BattleQueueTypeInfoVO) : void
      {
         this._typeInfo = param1;
         invalidate(INV_TYPE_INFO);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:String = null;
         var _loc8_:Boolean = false;
         super.draw();
         if(this._typeInfo && isInvalid(INV_TYPE_INFO))
         {
            _loc1_ = this._typeInfo.layoutStr;
            if(this._viewFrameHelper.getFrameByLabel(_loc1_) != FrameHelper.NOT_EXIST_INDEX)
            {
               gotoAndStop(_loc1_);
               if(_baseDisposed)
               {
                  return;
               }
               this.updateStage(parent.width,parent.height);
               this.listByType.height = getListHeight(_loc1_);
            }
            this.modeTitle.text = this._typeInfo.title;
            this.subTitle.htmlText = this._typeInfo.subTitle;
            this.footerText.text = this._typeInfo.footerText;
            this.battleIcon.visible = true;
            this.battleIcon.source = this._typeInfo.iconPath;
            if(this.battleTypeIcon)
            {
               this.battleTypeIcon.source = this._typeInfo.battleTypeIconPath;
            }
            _loc2_ = this._typeInfo.iconLabel;
            if(this._battleIconBgFrameHelper.getFrameByLabel(_loc2_) != FrameHelper.NOT_EXIST_INDEX)
            {
               this.battleIconBg.gotoAndStop(_loc2_);
            }
            else if(_loc2_.indexOf(FUN_RANDOM_BATTLE_ICON_BG) != -1)
            {
               this.battleIconBg.frameLabel = FUN_RANDOM_BATTLE_ICON_BG;
            }
            else
            {
               this.battleIconBg.gotoAndStop(LAYOUT_TYPE_EMPTY);
            }
            if(_baseDisposed)
            {
               return;
            }
            this.gameplayTip.text = this._typeInfo.description;
            this.additional.htmlText = this._typeInfo.additional;
            _loc3_ = this._typeInfo.tankLabel;
            _loc4_ = StringUtils.isNotEmpty(_loc3_);
            this.tankLabel.visible = _loc4_;
            if(_loc4_)
            {
               this.tankLabel.htmlText = _loc3_;
               App.utils.commons.updateTextFieldSize(this.tankLabel,true,false);
            }
            _loc5_ = this._typeInfo.tankIcon;
            _loc6_ = StringUtils.isNotEmpty(_loc5_);
            this.tankIcon.visible = _loc6_;
            if(_loc6_)
            {
               this.tankIcon.source = _loc5_;
               this.tankIcon.x = this.tankLabel.x + this.tankLabel.width + TNK_ICON_OFFSET ^ 0;
            }
            _loc7_ = this._typeInfo.tankName;
            _loc8_ = StringUtils.isNotEmpty(_loc7_);
            this.tankName.visible = _loc8_;
            if(_loc8_)
            {
               this.tankName.htmlText = this._typeInfo.tankName;
               this.tankName.x = this.tankIcon.x + TNK_ICON_OFFSET;
               App.utils.commons.updateTextFieldSize(this.tankName,true,false);
            }
         }
      }
      
      public function as_setPlayers(param1:String) : void
      {
         this.playersLabel.htmlText = param1;
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
      
      public function as_showStart(param1:Boolean) : void
      {
         this.startButton.visible = param1;
      }
      
      private function onExitButtonClickHandler(param1:ButtonEvent) : void
      {
         exitClickS();
      }
      
      private function onStartButtonClickHandler(param1:ButtonEvent) : void
      {
         startClickS();
      }
      
      private function handleEscape(param1:InputEvent) : void
      {
         onEscapeS();
      }
   }
}
