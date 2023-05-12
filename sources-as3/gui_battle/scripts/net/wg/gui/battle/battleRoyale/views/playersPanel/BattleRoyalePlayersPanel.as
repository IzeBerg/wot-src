package net.wg.gui.battle.battleRoyale.views.playersPanel
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.infrastructure.base.meta.IBattleRoyalePlayersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyalePlayersPanelMeta;
   import net.wg.utils.IClassFactory;
   import scaleform.gfx.MouseEventEx;
   
   public class BattleRoyalePlayersPanel extends BattleRoyalePlayersPanelMeta implements IBattleRoyalePlayersPanelMeta
   {
      
      private static const PLAYERS_PANEL_LIST_SEPARATOR_LINKAGE:String = "BattleRoyalePlayersPanelSeparatorUI";
      
      private static const PLAYERS_PANEL_LIST_ITEM_LINKAGE:String = "BattleRoyalePlayersPanelListItemUI";
      
      private static const ITEM_RENDERER_BASE_HEIGHT:int = 24;
      
      private static const SEPARATOR_Y_OFFSET:int = -1;
      
      private static const DEADBG_Y_OFFSET:int = -2;
      
      private static const TEAM_ITEMS_GAP:int = 2;
       
      
      public var shadowBg:Sprite = null;
      
      public var deadBg:Sprite = null;
      
      private var _items:Vector.<PlayersPanelItemRenderer> = null;
      
      private var _separators:Vector.<Sprite> = null;
      
      private var _classFactory:IClassFactory;
      
      private var _showSeparators:Boolean = false;
      
      public function BattleRoyalePlayersPanel()
      {
         this._classFactory = App.utils.classFactory;
         super();
         this._items = new Vector.<PlayersPanelItemRenderer>();
         this._separators = new Vector.<Sprite>();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:PlayersPanelItemRenderer = null;
         this._classFactory = null;
         for each(_loc1_ in this._separators)
         {
            removeChild(_loc1_);
         }
         this._separators = null;
         for each(_loc2_ in this._items)
         {
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onItemClickHandler);
            removeChild(_loc2_);
            _loc2_.dispose();
         }
         this._items = null;
         this.deadBg = null;
         this.shadowBg = null;
         super.onDispose();
      }
      
      public function as_setSeparatorVisibility(param1:Boolean) : void
      {
         this._showSeparators = param1;
      }
      
      override protected function setPlayersData(param1:Vector.<PlayerDataVO>, param2:int) : void
      {
         var _loc4_:PlayerDataVO = null;
         var _loc3_:PlayersPanelItemRenderer = null;
         _loc4_ = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Sprite = null;
         var _loc8_:PlayerDataVO = null;
         var _loc9_:int = 0;
         while(_loc9_ < param1.length)
         {
            if(_loc9_ > 0)
            {
               _loc8_ = _loc4_;
            }
            _loc4_ = param1[_loc9_];
            _loc3_ = this.getItemByIndex(_loc9_);
            if(_loc8_ != null && _loc4_.teamIndex != _loc8_.teamIndex)
            {
               _loc5_ += TEAM_ITEMS_GAP;
               if(this._showSeparators)
               {
                  _loc7_ = this.getSeparatorByIndex(_loc6_++);
                  _loc7_.y = ITEM_RENDERER_BASE_HEIGHT * _loc9_ + _loc5_ + SEPARATOR_Y_OFFSET;
               }
            }
            _loc3_.y = ITEM_RENDERER_BASE_HEIGHT * _loc9_ + _loc5_;
            _loc3_.data = _loc4_;
            if(_loc9_ == param2)
            {
               this.deadBg.y = _loc3_.y + DEADBG_Y_OFFSET;
               this.deadBg.visible = true;
            }
            _loc9_++;
         }
         if(_loc3_ != null)
         {
            this.shadowBg.height = _loc3_.y + ITEM_RENDERER_BASE_HEIGHT;
         }
      }
      
      private function getItemByIndex(param1:uint) : PlayersPanelItemRenderer
      {
         var _loc2_:PlayersPanelItemRenderer = null;
         while(param1 >= this._items.length)
         {
            _loc2_ = this._classFactory.getComponent(PLAYERS_PANEL_LIST_ITEM_LINKAGE,PlayersPanelItemRenderer);
            _loc2_.addEventListener(MouseEvent.CLICK,this.onItemClickHandler);
            addChild(_loc2_);
            this._items.push(_loc2_);
         }
         return this._items[param1];
      }
      
      private function getSeparatorByIndex(param1:uint) : Sprite
      {
         var _loc2_:Sprite = null;
         while(param1 >= this._separators.length)
         {
            _loc2_ = this._classFactory.getComponent(PLAYERS_PANEL_LIST_SEPARATOR_LINKAGE,Sprite);
            addChild(_loc2_);
            this._separators.push(_loc2_);
         }
         return this._separators[param1];
      }
      
      private function onItemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         if(_loc2_ != null && _loc2_.buttonIdx != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         var _loc3_:PlayersPanelItemRenderer = param1.target as PlayersPanelItemRenderer;
         if(_loc3_ != null)
         {
            switchToPlayerS(_loc3_.vehicleID);
         }
      }
   }
}
