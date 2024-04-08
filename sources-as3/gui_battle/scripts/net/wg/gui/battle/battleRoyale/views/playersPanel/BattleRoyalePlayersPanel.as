package net.wg.gui.battle.battleRoyale.views.playersPanel
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.meta.IBattleRoyalePlayersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyalePlayersPanelMeta;
   import net.wg.utils.IClassFactory;
   import scaleform.gfx.MouseEventEx;
   
   public class BattleRoyalePlayersPanel extends BattleRoyalePlayersPanelMeta implements IBattleRoyalePlayersPanelMeta
   {
      
      private static const PLAYERS_PANEL_LIST_SEPARATOR_LINKAGE:String = "BattleRoyalePlayersPanelSeparatorUI";
      
      private static const PLAYERS_PANEL_LIST_RESPAWN_LINKAGE:String = "BRPlayersPanelRespUI";
      
      private static const PLAYERS_PANEL_LIST_ITEM_LINKAGE:String = "BattleRoyalePlayersPanelListItemUI";
      
      private static const ITEM_RENDERER_BASE_HEIGHT:int = 30;
      
      private static const ITEM_RENDERER_SMALL_HEIGHT:int = 24;
       
      
      public var shadowBg:Sprite = null;
      
      public var deadBg:Sprite = null;
      
      private var _data:Vector.<PlayerDataVO> = null;
      
      private var _lostIndex:int = -1;
      
      private var _isSquadMode:Boolean = false;
      
      private var _isRespawnVisible:Boolean = true;
      
      private var _items:Vector.<PlayersPanelItemRenderer> = null;
      
      private var _respawnIcons:Dictionary = null;
      
      private var _separators:Vector.<Sprite> = null;
      
      private var _classFactory:IClassFactory;
      
      public function BattleRoyalePlayersPanel()
      {
         this._classFactory = App.utils.classFactory;
         super();
         this._items = new Vector.<PlayersPanelItemRenderer>();
         this._separators = new Vector.<Sprite>();
         this._respawnIcons = new Dictionary();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:Sprite = null;
         var _loc3_:PlayersPanelItemRenderer = null;
         removeEventListener(RespawnIconEvent.ALPHA_CHANGE,this.onRespawnAlphaChangeHandler);
         this._classFactory = null;
         for each(_loc1_ in this._separators)
         {
            removeChild(_loc1_);
         }
         this._separators = null;
         for each(_loc2_ in this._respawnIcons)
         {
            removeChild(_loc2_);
         }
         this._respawnIcons = null;
         for each(_loc3_ in this._items)
         {
            _loc3_.removeEventListener(MouseEvent.CLICK,this.onItemClickHandler);
            removeChild(_loc3_);
            _loc3_.dispose();
         }
         this._data = null;
         this._items = null;
         this.deadBg = null;
         this.shadowBg = null;
         super.onDispose();
      }
      
      override protected function setPlayersData(param1:Vector.<PlayerDataVO>, param2:int) : void
      {
         this._data = param1;
         this._lostIndex = param2;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:PlayersPanelItemRenderer = null;
         var _loc2_:PlayersPanelItemRenderer = null;
         var _loc3_:PlayerDataVO = null;
         var _loc4_:int = 0;
         var _loc5_:Sprite = null;
         var _loc6_:PlayerDataVO = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:Dictionary = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Sprite = null;
         var _loc14_:* = null;
         super.draw();
         _loc1_ = null;
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            _loc2_ = null;
            _loc3_ = null;
            _loc4_ = 0;
            _loc5_ = null;
            _loc6_ = null;
            _loc7_ = 1;
            _loc8_ = this._data.length;
            _loc9_ = new Dictionary();
            _loc10_ = 0;
            while(_loc10_ < _loc8_)
            {
               if(_loc10_ > 0)
               {
                  _loc6_ = _loc3_;
               }
               _loc3_ = this._data[_loc10_];
               _loc1_ = this.getItemByIndex(_loc10_);
               if(_loc6_ != null && _loc3_.teamIndex != _loc6_.teamIndex)
               {
                  _loc7_ = 1;
                  _loc5_ = this.getSeparatorByIndex(_loc4_++);
                  _loc5_.y = this.itemRendererHeight * _loc10_;
               }
               if(_loc9_[_loc3_.teamIndex] === undefined)
               {
                  _loc9_[_loc3_.teamIndex] = 0;
               }
               _loc9_[_loc3_.teamIndex] += 1;
               this.getRespawnByTeam(_loc3_.teamIndex).visible = _loc3_.hasRespawn;
               _loc1_.y = this.itemRendererHeight * _loc10_;
               _loc1_.data = _loc3_;
               _loc1_.setIsDead(this._lostIndex != Values.DEFAULT_INT && _loc10_ >= this._lostIndex);
               _loc2_ = _loc1_;
               _loc7_++;
               _loc10_++;
            }
            _loc11_ = 0;
            _loc12_ = 0;
            _loc13_ = null;
            for(_loc14_ in _loc9_)
            {
               _loc12_ = this.itemRendererHeight * _loc9_[_loc14_] >> 1;
               _loc13_ = this.getRespawnByTeam(_loc14_ as int);
               _loc13_.y = _loc11_ + _loc12_;
               _loc11_ = _loc13_.y + _loc12_;
            }
            if(_loc1_ != null)
            {
               this.shadowBg.height = _loc1_.y + this.itemRendererHeight;
            }
         }
         if(isInvalid(InvalidationType.STATE))
         {
            for each(_loc1_ in this._items)
            {
               _loc1_.setIsSquadMode(this._isSquadMode);
               _loc1_.setIsRespawnAvailable(this._isRespawnVisible);
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(RespawnIconEvent.ALPHA_CHANGE,this.onRespawnAlphaChangeHandler);
      }
      
      public function as_setIsSquadMode(param1:Boolean) : void
      {
         this._isSquadMode = param1;
         invalidateState();
      }
      
      public function as_setRespawnVisibility(param1:Boolean) : void
      {
         this._isRespawnVisible = param1;
         invalidateState();
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
      
      private function getRespawnByTeam(param1:uint) : Sprite
      {
         var _loc2_:Sprite = null;
         if(!this._respawnIcons[param1])
         {
            _loc2_ = this._classFactory.getComponent(PLAYERS_PANEL_LIST_RESPAWN_LINKAGE,Sprite);
            addChild(_loc2_);
            this._respawnIcons[param1] = _loc2_;
         }
         return this._respawnIcons[param1];
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
      
      private function get itemRendererHeight() : int
      {
         return !!this._isSquadMode ? int(ITEM_RENDERER_SMALL_HEIGHT) : int(ITEM_RENDERER_BASE_HEIGHT);
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
      
      private function onRespawnAlphaChangeHandler(param1:RespawnIconEvent) : void
      {
         this.getRespawnByTeam(param1.teamIndex).alpha = param1.alpha;
      }
   }
}
