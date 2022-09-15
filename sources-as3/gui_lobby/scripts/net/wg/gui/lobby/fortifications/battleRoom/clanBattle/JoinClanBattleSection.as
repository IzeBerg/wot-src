package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
   import flash.display.InteractiveObject;
   import net.wg.gui.lobby.fortifications.battleRoom.JoinSortieSection;
   import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleDetailsVO;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.infrastructure.events.FocusChainChangeEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class JoinClanBattleSection extends JoinSortieSection
   {
       
      
      public var battleCreator:ClanBattleCreatorView;
      
      public function JoinClanBattleSection()
      {
         super();
         vehiclesInfoTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_TEAMVEHICLESSTUB;
         descriptionTF.mouseEnabled = headerTF.mouseEnabled = false;
         TextFieldEx.setVerticalAlign(descriptionTF,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(headerTF,TextFieldEx.VALIGN_CENTER);
      }
      
      override public function getFocusChain() : Vector.<InteractiveObject>
      {
         if(this.battleCreator.visible)
         {
            return new <InteractiveObject>[this.battleCreator.applyButton];
         }
         return super.getFocusChain();
      }
      
      override public function setData(param1:IRallyVO) : void
      {
         super.setData(param1);
      }
      
      override protected function updateRallyInfoTF() : void
      {
         if(model != null && model.hasSlotsData())
         {
            super.updateRallyInfoTF();
         }
      }
      
      override protected function updateDescription(param1:IRallyVO) : void
      {
         descriptionTF.htmlText = param1.description;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         vehiclesLabel = FORTIFICATIONS.SORTIE_LISTVIEW_TEAMVEHICLESSTUB;
      }
      
      override protected function onDispose() : void
      {
         this.battleCreator.dispose();
         this.battleCreator = null;
         super.onDispose();
      }
      
      override protected function setChangedVisibilityItems() : void
      {
         super.setChangedVisibilityItems();
      }
      
      override protected function updateNoRallyScreen(param1:Boolean) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = false;
         if(model != null)
         {
            _loc2_ = ClanBattleDetailsVO(model).isCreationAvailable;
         }
         _loc3_ = _loc2_ && param1;
         this.battleCreator.visible = _loc3_;
         if(_loc3_)
         {
            this.battleCreator.setData(ClanBattleDetailsVO(model));
         }
         if(_loc3_)
         {
            updateNoRallyScreenVisibility(false);
            updateElementsVisibility(false);
         }
         else
         {
            super.updateNoRallyScreen(param1);
         }
         dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
      }
      
      override protected function updateTitle(param1:IRallyVO) : void
      {
         userInfoTextLoadingController.setUserNameHtmlText(ClanBattleDetailsVO(model).detailsTitle);
      }
   }
}
