package net.wg.gui.battle.ranked.stats.components.playersPanel.list
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IRankedPlayersPanelListItem;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelItemEvent;
   
   public class PlayersPanelListItem extends BasePlayersPanelListItem implements IRankedPlayersPanelListItem
   {
      
      private static const RANK_ICON_AREA_WIDTH:int = 24;
      
      private static const RANK_ICON_OFFSET:int = 3;
      
      private static const DOG_TAG_ICON_AREA_WIDTH:int = 22;
      
      private static const DOG_TAG_OFFSET:int = -3;
       
      
      public var rankIcon:BattleAtlasSprite = null;
      
      private var _level:int;
      
      private var _division:int;
      
      private var _isGroup:Boolean;
      
      public function PlayersPanelListItem()
      {
         super();
         maxPlayerNameWidth = WIDTH - ICONS_AREA_WIDTH - vehicleTF.width - fragsTF.width - RANK_ICON_AREA_WIDTH;
         this.rankIcon.mouseEnabled = this.rankIcon.mouseChildren = false;
      }
      
      override public function isSquadPersonal() : Boolean
      {
         return false;
      }
      
      override protected function onDispose() : void
      {
         this.rankIcon = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Function = null;
         super.draw();
         if(isInvalid(PlayersPanelInvalidationType.RANK_CHANGED))
         {
            this.rankIcon.visible = this._level > -1 || this._division > -1;
            if(this.rankIcon.visible)
            {
               _loc1_ = !!this._isGroup ? BATTLEATLAS.getRanksGroupIcon : BATTLEATLAS.getRankIcon;
               this.rankIcon.imageName = _loc1_(this._division.toString(),this._level.toString());
            }
         }
      }
      
      override protected function updateDogTag() : void
      {
         dogTag.visible = true;
      }
      
      override protected function updatePositionsRight() : void
      {
         super.updatePositionsRight();
         x = -(fragsTF.x + fragsTF.width + RANK_ICON_AREA_WIDTH + DOG_TAG_ICON_AREA_WIDTH ^ 0);
         this.rankIcon.x = fragsTF.x + fragsTF.width - RANK_ICON_OFFSET ^ 0;
         dogTag.x = this.rankIcon.x + RANK_ICON_AREA_WIDTH + DOG_TAG_OFFSET;
      }
      
      override protected function updatePositionsLeft() : void
      {
         super.updatePositionsLeft();
         x = -(fragsTF.x - RANK_ICON_AREA_WIDTH - DOG_TAG_ICON_AREA_WIDTH ^ 0);
         this.rankIcon.x = fragsTF.x - RANK_ICON_AREA_WIDTH + RANK_ICON_OFFSET ^ 0;
      }
      
      public function setRankIcon(param1:int, param2:int, param3:Boolean) : void
      {
         if(this._level == param2 && this._division == param1)
         {
            return;
         }
         this._level = param2;
         this._division = param1;
         this._isGroup = param3;
         invalidate(PlayersPanelInvalidationType.RANK_CHANGED);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_OVER,null,holderItemID,param1);
         dispatchEvent(_loc2_);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_OUT,null,holderItemID,param1);
         dispatchEvent(_loc2_);
      }
      
      override protected function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_CLICK,null,holderItemID,param1);
         dispatchEvent(_loc2_);
      }
   }
}
