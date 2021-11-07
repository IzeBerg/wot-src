package net.wg.gui.lobby.eventBattleResult.components
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class BuddiesHeader extends UIComponentEx
   {
       
      
      public var platoon:BuddiesColumnHeader = null;
      
      public var tank:BuddiesColumnHeader = null;
      
      public var matter:BuddiesColumnHeader = null;
      
      public var kills:BuddiesColumnHeader = null;
      
      public var damage:BuddiesColumnHeader = null;
      
      public var blocked:BuddiesColumnHeader = null;
      
      public var keys:BuddiesColumnHeader = null;
      
      public var medals:BuddiesColumnHeader = null;
      
      public var header:BuddiesColumnHeader = null;
      
      private var _headerItems:Vector.<BuddiesColumnHeader> = null;
      
      private var _data:ResultDataVO = null;
      
      private var _selected:BuddiesColumnHeader;
      
      public function BuddiesHeader()
      {
         this._selected = this.tank;
         super();
         this._headerItems = new <BuddiesColumnHeader>[this.matter,this.kills,this.damage,this.blocked,this.keys,this.medals,this.platoon,this.header,this.tank];
      }
      
      override protected function configUI() : void
      {
         var _loc1_:DisplayObject = null;
         super.configUI();
         this.header.setText(EVENT.RESULTSCREEN_TEAMMATES);
         for each(_loc1_ in this._headerItems)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         var _loc1_:DisplayObject = null;
         for each(_loc1_ in this._headerItems)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._headerItems.splice(0,this._headerItems.length);
         this._headerItems = null;
         this.matter.dispose();
         this.matter = null;
         this.kills.dispose();
         this.kills = null;
         this.damage.dispose();
         this.damage = null;
         this.blocked.dispose();
         this.blocked = null;
         this.keys.dispose();
         this.keys = null;
         this.medals.dispose();
         this.medals = null;
         this.header.dispose();
         this.header = null;
         this.platoon.dispose();
         this.platoon = null;
         this.tank.dispose();
         this.tank = null;
         this._data = null;
         this._selected = null;
         super.onDispose();
      }
      
      public function setData(param1:ResultDataVO) : void
      {
         this._data = param1;
         this.platoon.setHeaderData(ResultBuddies.PLATOON_SORT,param1.platoonTooltip);
         this.tank.setHeaderData(ResultBuddies.TANK_SORT,param1.tankTooltip);
         this.header.setHeaderData(ResultBuddies.NAME_SORT,param1.nameTooltip);
         this.matter.setHeaderData(ResultBuddies.MATTER_SORT,param1.matterTooltip);
         this.kills.setHeaderData(ResultBuddies.KILLS_SORT,param1.killsTooltip);
         this.damage.setHeaderData(ResultBuddies.DAMAGE_SORT,param1.damageTooltip);
         this.blocked.setHeaderData(ResultBuddies.BLOCKED_SORT,param1.blockedTooltip);
         this.keys.setHeaderData(ResultBuddies.KEYS_SORT,param1.keysTooltip);
         this.medals.setHeaderData(ResultBuddies.MEDALS_SORT,param1.medalsTooltip);
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BuddiesColumnHeader = BuddiesColumnHeader(param1.target);
         if(_loc2_ != this._selected)
         {
            if(this._selected)
            {
               this._selected.setSelected(false);
            }
            this._selected = _loc2_;
            this._selected.setSelected(true);
         }
         else if(this._selected)
         {
            this._selected.flipSortingDirection();
         }
      }
   }
}
