package net.wg.gui.battle.halloween.playersList
{
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItem;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class HWPlayersPanelListItem extends PlayersPanelListItem
   {
      
      private static const SQUAD_POSTFIX:String = "_orange";
      
      private static const ENEMY_POSTFIX:String = "_red";
      
      private static const BUFF_LEFT_PADDING:int = 346;
      
      private static const BUFF_RIGHT_PADDING:int = -410;
      
      private static const CHAT_COMMAND_STATE_ICON_OFFSET_LEFT:int = 40;
      
      private static const CHAT_COMMAND_STATE_ICON_OFFSET_RIGHT:int = -40;
       
      
      public var buffIcon:BattleAtlasSprite = null;
      
      private var _buffIconName:String = "";
      
      public function HWPlayersPanelListItem()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.buffIcon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.buffIcon.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(PlayersPanelInvalidationType.PLAYER_SCHEME))
         {
            this.updateBuffColors();
         }
      }
      
      private function setChatCommandStateIconOffset() : void
      {
         var _loc1_:int = 0;
         if(getIsRightAligned())
         {
            if(this.buffIcon.visible)
            {
               _loc1_ = CHAT_COMMAND_STATE_ICON_OFFSET_RIGHT;
            }
         }
         else if(this.buffIcon.visible)
         {
            _loc1_ = CHAT_COMMAND_STATE_ICON_OFFSET_LEFT;
         }
         chatCommandState.iconOffset(chatCommandState.getIconOffset(),_loc1_);
      }
      
      override protected function updatePositionsLeft() : void
      {
         super.updatePositionsLeft();
         this.buffIcon.x = BUFF_LEFT_PADDING;
         this.setChatCommandStateIconOffset();
      }
      
      override protected function updatePositionsRight() : void
      {
         super.updatePositionsRight();
         this.buffIcon.x = BUFF_RIGHT_PADDING;
         this.setChatCommandStateIconOffset();
      }
      
      public function setBuffIcon(param1:String) : void
      {
         this._buffIconName = param1;
         if(StringUtils.isNotEmpty(this._buffIconName))
         {
            this.buffIcon.visible = true;
            this.buffIcon.imageName = this._buffIconName + this.getIconPostfix();
         }
         else
         {
            this.buffIcon.visible = false;
         }
         this.setChatCommandStateIconOffset();
      }
      
      private function getIconPostfix() : String
      {
         if(isSquadPersonal())
         {
            return SQUAD_POSTFIX;
         }
         if(getIsRightAligned())
         {
            return ENEMY_POSTFIX;
         }
         return Values.EMPTY_STR;
      }
      
      private function updateBuffColors() : void
      {
         if(this.buffIcon.visible)
         {
            this.buffIcon.imageName = this._buffIconName + this.getIconPostfix();
         }
      }
   }
}
