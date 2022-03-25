package net.wg.gui.lobby.battlequeue
{
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.icons.BattleTypeIcon;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.base.meta.IBattleQueueMeta;
   import net.wg.infrastructure.base.meta.impl.BattleQueueMeta;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   
   public class BattleQueueBase extends BattleQueueMeta implements IBattleQueueMeta
   {
      
      protected static const INV_TYPE_INFO:String = "InvTypeInfo";
       
      
      public var timerLabel:TextField;
      
      public var timerText:TextField;
      
      public var tankLabel:TextField;
      
      public var tankName:TextField;
      
      public var playersLabel:TextField;
      
      public var gameplayTip:TextField;
      
      public var additional:TextField;
      
      public var modeTitle:TextField;
      
      public var exitButton:ISoundButtonEx;
      
      public var listByType:ScrollingListEx;
      
      public var startButton:ISoundButtonEx;
      
      public var battleIcon:BattleTypeIcon;
      
      public var battleIconBg:FrameStateCmpnt;
      
      protected var _typeInfo:BattleQueueTypeInfoVO;
      
      public function BattleQueueBase()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.startButton.visible = false;
         this.listByType.mouseChildren = false;
         this.startButton.addEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
         this.exitButton.addEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
      }
      
      override protected function onDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
         this.listByType.disposeRenderers();
         this.startButton.removeEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
         this.exitButton.removeEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
         this.timerLabel = null;
         this.timerText = null;
         this.tankLabel = null;
         this.tankName = null;
         this.playersLabel = null;
         this.gameplayTip = null;
         this.additional = null;
         this.modeTitle = null;
         this.exitButton.dispose();
         this.exitButton = null;
         this.listByType.dispose();
         this.listByType = null;
         this.startButton.dispose();
         this.startButton = null;
         if(this.battleIcon)
         {
            this.battleIcon.dispose();
            this.battleIcon = null;
         }
         if(this.battleIconBg)
         {
            this.battleIconBg.dispose();
            this.battleIconBg = null;
         }
         this._typeInfo.dispose();
         this._typeInfo = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
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
      
      public function get typeInfo() : BattleQueueTypeInfoVO
      {
         return this._typeInfo;
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
