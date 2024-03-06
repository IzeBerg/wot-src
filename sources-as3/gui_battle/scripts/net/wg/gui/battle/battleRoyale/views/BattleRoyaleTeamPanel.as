package net.wg.gui.battle.battleRoyale.views
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.meta.IBattleRoyaleTeamPanelMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleTeamPanelMeta;
   
   public class BattleRoyaleTeamPanel extends BattleRoyaleTeamPanelMeta implements IBattleRoyaleTeamPanelMeta
   {
      
      private static const PADDING_H:uint = 40;
      
      private static const LIST_PADDING_V:uint = 52;
      
      private static const PADDING_V:uint = 16;
      
      private static const TITLE_TF_ALPHA:Number = 0.5;
      
      private static const BLINK_DEAD_FRAME_LABEL:String = "die";
      
      private static const BLINK_REVIVE_FRAME_LABEL:String = "revive";
       
      
      public var titleTF:TextField = null;
      
      public var bg:MovieClip = null;
      
      public var bgBlinkMC:MovieClip = null;
      
      private var _renderersContainer:Sprite = null;
      
      private var _listItems:Vector.<BattleRoyaleTeamPanelListItem> = null;
      
      public function BattleRoyaleTeamPanel()
      {
         super();
         this._renderersContainer = new Sprite();
         addChild(this._renderersContainer);
         this._listItems = new Vector.<BattleRoyaleTeamPanelListItem>(0);
         this.titleTF.alpha = TITLE_TF_ALPHA;
         this.titleTF.visible = false;
         this.bg.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.removeAllItems();
         this.titleTF = null;
         this.bg = null;
         this.bgBlinkMC = null;
         this._renderersContainer = null;
         this._listItems = null;
         super.onDispose();
      }
      
      override protected function setInitData(param1:String, param2:Array, param3:Array) : void
      {
         this.titleTF.text = param1;
         this.removeAllItems();
         var _loc4_:uint = Values.ZERO;
         var _loc5_:uint = param2.length;
         var _loc6_:BattleRoyaleTeamPanelListItem = null;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = this.addItem();
            _loc6_.setPlayerName(param2[_loc4_]);
            if(param3[_loc4_])
            {
               _loc6_.setClanName(param3[_loc4_]);
            }
            _loc4_++;
         }
         this.titleTF.visible = this.bg.visible = Boolean(this._listItems.length);
      }
      
      public function as_setPlayerFrags(param1:int, param2:String) : void
      {
         var _loc3_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc3_)
         {
            _loc3_.setFrags(param2);
         }
      }
      
      public function as_setPlayerHP(param1:int, param2:int) : void
      {
         var _loc3_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc3_)
         {
            _loc3_.setProgress(param2);
         }
      }
      
      public function as_setPlayerState(param1:int, param2:Boolean, param3:Boolean, param4:int, param5:String, param6:String, param7:String) : void
      {
         var _loc8_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc8_)
         {
            _loc8_.setAlive(param2);
            _loc8_.setReady(param3);
            _loc8_.setProgress(param4);
            _loc8_.setFrags(param5);
            _loc8_.setVehicleLevel(param6);
            _loc8_.setVehicleIcon(param7);
         }
      }
      
      public function as_setPlayerStatus(param1:int, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc5_)
         {
            _loc5_.setAlive(param2);
            _loc5_.setReady(param3);
            _loc5_.setIsRespawning(param4);
         }
      }
      
      public function as_setPlayerVehicle(param1:int, param2:String) : void
      {
         var _loc3_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc3_)
         {
            _loc3_.setVehicleIcon(param2);
         }
      }
      
      public function as_setVehicleLevel(param1:int, param2:String) : void
      {
         var _loc3_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc3_)
         {
            _loc3_.setVehicleLevel(param2);
         }
      }
      
      private function getListItem(param1:int) : BattleRoyaleTeamPanelListItem
      {
         var _loc2_:BattleRoyaleTeamPanelListItem = null;
         if(param1 < this._listItems.length)
         {
            _loc2_ = this._listItems[param1];
         }
         else
         {
            App.utils.asserter.assert(false,"Wrong list item index, " + param1);
         }
         return _loc2_;
      }
      
      private function addItem() : BattleRoyaleTeamPanelListItem
      {
         var _loc1_:BattleRoyaleTeamPanelListItem = null;
         _loc1_ = App.utils.classFactory.getComponent(Linkages.TEAM_PANEL_LIST_ITEM,BattleRoyaleTeamPanelListItem);
         _loc1_.x = PADDING_H;
         _loc1_.y = this._listItems.length * (_loc1_.height + PADDING_V) + LIST_PADDING_V;
         _loc1_.addEventListener(BattleRoyaleTeamPanelListItem.EVENT_TYPE_DEAD,this.onRendererDeadHandler);
         _loc1_.addEventListener(BattleRoyaleTeamPanelListItem.EVENT_TYPE_REVIVE,this.onRendererReviveHandler);
         this._listItems.push(_loc1_);
         this._renderersContainer.addChild(_loc1_);
         return _loc1_;
      }
      
      private function removeAllItems() : void
      {
         var _loc1_:BattleRoyaleTeamPanelListItem = null;
         for each(_loc1_ in this._listItems)
         {
            _loc1_.removeEventListener(BattleRoyaleTeamPanelListItem.EVENT_TYPE_REVIVE,this.onRendererReviveHandler);
            _loc1_.removeEventListener(BattleRoyaleTeamPanelListItem.EVENT_TYPE_DEAD,this.onRendererDeadHandler);
            this._renderersContainer.removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._listItems.splice(Values.ZERO,this._listItems.length);
      }
      
      private function onRendererDeadHandler(param1:Event) : void
      {
         this.bgBlinkMC.gotoAndPlay(BLINK_DEAD_FRAME_LABEL);
      }
      
      private function onRendererReviveHandler(param1:Event) : void
      {
         this.bgBlinkMC.gotoAndPlay(BLINK_REVIVE_FRAME_LABEL);
      }
   }
}
