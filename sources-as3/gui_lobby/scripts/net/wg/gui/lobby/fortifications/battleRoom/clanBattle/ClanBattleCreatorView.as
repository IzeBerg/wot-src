package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleDetailsVO;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class ClanBattleCreatorView extends UIComponentEx
   {
       
      
      public var applyButton:SoundButtonEx;
      
      public var creatorTitle:TextField;
      
      public var creatorDescr:TextField;
      
      public function ClanBattleCreatorView()
      {
         super();
         TextFieldEx.setVerticalAlign(this.creatorTitle,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.creatorDescr,TextFieldEx.VALIGN_TOP);
         this.creatorDescr.mouseEnabled = false;
         this.applyButton.enabled = false;
      }
      
      public function setData(param1:ClanBattleDetailsVO) : void
      {
         this.creatorTitle.htmlText = param1.titleText;
         this.creatorDescr.htmlText = param1.descrText;
         this.applyButton.label = param1.buttonLbl;
         this.applyButton.enabled = param1.isEnableBtn;
         if(this.applyButton.enabled)
         {
            this.applyButton.addEventListener(ButtonEvent.CLICK,this.applyButton_buttonClickHandler);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updatePosition([this.applyButton,this.creatorTitle,this.creatorDescr]);
      }
      
      override protected function onDispose() : void
      {
         this.applyButton.removeEventListener(ButtonEvent.CLICK,this.applyButton_buttonClickHandler);
         this.applyButton.dispose();
         this.applyButton = null;
         this.creatorTitle = null;
         this.creatorDescr = null;
         super.onDispose();
      }
      
      private function updatePosition(param1:Array) : void
      {
         var _loc2_:InteractiveObject = null;
         for each(_loc2_ in param1)
         {
            _loc2_.x = Math.round((this.width - _loc2_.width) / 2);
         }
      }
      
      private function applyButton_buttonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.CREATE_CLAN_BATTLE_ROOM,param1));
      }
   }
}
