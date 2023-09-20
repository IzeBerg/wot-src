package net.wg.gui.battle.random.views.stats.components.playersPanel.list
{
   import flash.events.MouseEvent;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IRandomPlayersPanelListItem;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   
   public class PlayersPanelListItem extends BasePlayersPanelListItem implements IRandomPlayersPanelListItem
   {
      
      protected static const SQUAD_ITEMS_AREA_WIDTH:int = 25;
       
      
      private var _isSquadPersonal:Boolean = false;
      
      public function PlayersPanelListItem()
      {
         super();
         maxPlayerNameWidth = WIDTH - ICONS_AREA_WIDTH - vehicleTF.width - fragsTF.width - SQUAD_ITEMS_AREA_WIDTH - SQUAD_ITEMS_AREA_WIDTH - BADGE_OFFSET;
      }
      
      override public function getDynamicSquad() : PlayersPanelDynamicSquad
      {
         return dynamicSquad;
      }
      
      override public function isSquadPersonal() : Boolean
      {
         return this._isSquadPersonal;
      }
      
      override public function setIsInteractive(param1:Boolean) : void
      {
         dynamicSquad.setIsInteractive(param1);
      }
      
      override public function setIsInviteShown(param1:Boolean) : void
      {
         dynamicSquad.setIsInviteShown(param1);
      }
      
      override protected function onDispose() : void
      {
         dynamicSquad.dispose();
         dynamicSquad = null;
         super.onDispose();
      }
      
      override protected function updatePositionsRight() : void
      {
         x = -(fragsTF.x + fragsTF.width + SQUAD_ITEMS_AREA_WIDTH ^ 0);
         dynamicSquad.x = fragsTF.x + fragsTF.width + SQUAD_ITEMS_AREA_WIDTH ^ 0;
      }
      
      override protected function updatePositionsLeft() : void
      {
         x = -(fragsTF.x - SQUAD_ITEMS_AREA_WIDTH ^ 0);
         dynamicSquad.x = fragsTF.x - SQUAD_ITEMS_AREA_WIDTH ^ 0;
      }
      
      override protected function initializeRightAligned(param1:Boolean) : void
      {
         dynamicSquad.setIsEnemy(param1);
      }
      
      public function setSquad(param1:Boolean, param2:int) : void
      {
         dynamicSquad.setCurrentSquad(param1,param2);
         if(this._isSquadPersonal != param1)
         {
            this._isSquadPersonal = param1;
            invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
         }
      }
      
      public function setSquadNoSound(param1:Boolean) : void
      {
         dynamicSquad.setNoSound(param1);
      }
      
      public function setSquadState(param1:int) : void
      {
         dynamicSquad.setState(param1);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         super.onMouseOver(param1);
         dynamicSquad.onItemOver();
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
         dynamicSquad.onItemOut();
      }
   }
}
